library(dplyr)
library(ggplot2)
library(readr)
library(scales)
library(stringr)
library(tidyr)

theme_set(theme_bw())

read_allocation_file <- function(file) {
  read_delim(file, ",", col_names = c("allocation_timestamp", "pod_id", "deploy_id", "node",
                                      "waittime"),
             col_types = "icccn") %>%
    separate(deploy_id, into = c("slo_class", "task_id", "deploy_hash"), remove = FALSE) %>%
    select(-deploy_hash)
}

read_termination_file <- function(file) {
  read_delim(file, ",", col_names = c("termination_timestamp", "pod_id", "deploy_id", "runtime"),
             col_types = "iccn") %>%
    separate(deploy_id, into = c("slo_class", "task_id", "deploy_hash"), remove = FALSE) %>%
    select(-deploy_hash)
}

read_waiting_file <- function(file) {
  read_delim(file, ",", col_names = c("waiting_timestamp", "pod_id", "deploy_id"),
             col_types = "icc") %>%
    separate(deploy_id, into = c("slo_class", "task_id", "deploy_hash"), remove = FALSE) %>%
    select(-deploy_hash)
}

read_workload_file <- function(file) {
  read_csv(file, col_names = c("submit_time", "job_id", "task_id", "user", "scheduling_class",
                               "priority", "service_time", "end_time", "cpu_req", "mem_req",
                               "slo_class", "slo"),
           col_types = c("icccccnnnncn"))
}

load_results <- function(results_dir, workload_file, wait_tolerance = 0) {
  allocation <- read_allocation_file(paste0(results_dir, "/", "allocation.dat"))
  termination <- read_termination_file(paste0(results_dir, "/", "termination.dat"))
  waiting <- read_waiting_file(paste0(results_dir, "/", "waiting.dat"))
  workload <- read_workload_file(workload_file)
  
  res <- workload %>%
    full_join(waiting, by = c("task_id", "slo_class")) %>%
    full_join(allocation, by = c("deploy_id", "pod_id", "task_id", "slo_class")) %>%
    full_join(termination, by = c("deploy_id", "pod_id", "task_id", "slo_class"))
  
  max_timestamp <- with(res, max(termination_timestamp, allocation_timestamp,
                                 waiting_timestamp, na.rm = TRUE))
  
  res <- res %>%
    mutate(termination_timestamp = if_else(!is.na(termination_timestamp), termination_timestamp,
                                           max_timestamp),
           allocation_timestamp = if_else(!is.na(allocation_timestamp), allocation_timestamp,
                                          termination_timestamp),
           waittime = if_else(is.na(waittime), 0, pmax(waittime - wait_tolerance, 0)),
           slo_class = factor(slo_class, levels = c("prod", "batch", "free")))
  return(res)
}

calculate_results_over_time <- function(res_df) {
  res_time <- res_df %>%
    group_by(deploy_id, slo_class, slo) %>%
    mutate(previous_runtime = cumsum(runtime) - runtime,
           previous_waittime = cumsum(waittime) - waittime) %>%
    group_by(deploy_id, pod_id, slo_class, slo) %>%
    do(bind_rows(data_frame(time = seq(.$waiting_timestamp, .$allocation_timestamp-1, length.out = .$waittime),
                            waittime = .$previous_waittime + seq_len(.$waittime), runtime = .$previous_runtime),
                 data_frame(time = seq(.$allocation_timestamp, .$termination_timestamp-1, length.out = .$runtime),
                            waittime = .$previous_waittime + .$waittime,
                            runtime = .$previous_runtime + seq_len(.$runtime)))) %>%
    arrange(time) %>%
    group_by(deploy_id) %>%
    mutate(time = (time - min(time)) / 60,
           #runtime_acc = previous_runtime + runtime,
           #waittime_acc = previous_waittime + waittine,
           availability = runtime / (runtime + waittime))
  
  return(res_time)
}

calculate_results_stats <- function(res_df) {
  res_stats <- res_df %>%
    group_by(deploy_id, slo_class, slo) %>%
    summarise(submit_time = min(submit_time),
              waiting_time = sum(waittime, na.rm = TRUE),
              waiting_time2 = sum(allocation_timestamp - waiting_timestamp),
              running_time = sum(runtime, na.rm = TRUE),
              running_time2 = sum(termination_timestamp - allocation_timestamp),
              availability = running_time / (running_time + waiting_time))
  
  return(res_stats)
}

analyze_experiment_results <- function(results_dir, workload_file, plot_prefix, wait_tolerance = 0) {
  res_df <- load_results(results_dir, workload_file, wait_tolerance)
  res_time <- calculate_results_over_time(res_df)
  res_stats <- calculate_results_stats(res_df)
  
  plot_file <- paste0(plot_prefix, "_availability.png")
  p <- ggplot(res_stats, aes(slo_class, availability, col = slo_class)) +
    geom_hline(aes(yintercept = slo, col = slo_class, lty = slo_class)) +
    geom_jitter(alpha = 0.2, size = 2) +
    #geom_boxplot(outlier.shape = NA) +
    #facet_wrap(~ slo_class, ncol = 3) +
    xlab("SLO class") +
    scale_y_continuous(breaks = seq(0, 1, 0.2), labels = percent_format()) +
    coord_trans(limy = c(-0.05, 1.05)) +
    theme(legend.position = "none")
  ggsave(plot_file, p, width = 5, height = 3)
  
  plot_file <- paste0(plot_prefix, "_availability_over_time.png")
  p <- ggplot(res_time, aes(time, availability, group = deploy_id, col = slo_class)) +
    geom_hline(aes(yintercept = slo), lty = 2) +
    geom_line(alpha = 0.2) +
    scale_x_continuous("time (minutes)") +
    scale_y_continuous(breaks = seq(0, 1, 0.2), labels = percent_format()) +
    facet_wrap(~slo_class) +
    theme(legend.position = "none")
  ggsave(plot_file, p, width = 8, height = 3)

  res_stats %>%
    group_by(slo_class) %>%
    summarise(availability_mean = mean(availability))
}

main <- function(argv) {
  workload_dir <- "../data/"
  results_dirs <- list.files("../experiment-results", "2018*", full.names = TRUE)
  
  results_dir <- results_dirs[2]
  
  for (results_dir in results_dirs) {
    print(paste("Processing results for", results_dir))
    workload_prefix <- str_split(results_dir, "_", simplify = TRUE)[3]
    workload_file <- paste0(workload_dir, workload_prefix, ".csv")
    
    plot_prefix <- paste0(results_dir, "/", "exp_res_", workload_prefix)
    analyze_experiment_results(results_dir, workload_file, plot_prefix, 1)
  }
  
  # slo-driven, workload 1
  #workload_file <- "../../kubernetes-examples/data/synthetic-workload1-20hosts-10pods-per-host.csv"
  #analyze_experiment_results(results_dir, workload_file, "experiment_slo-driven_workload-1", 1)
  
  # priority, workload 1  
  #results_dir <- "../experiment-results/20180608_090833_synthetic-workload1-20hosts-10pods-per-host/"
  #analyze_experiment_results(results_dir, workload_file, "experiment_priority_workload-1", 1)  
}
