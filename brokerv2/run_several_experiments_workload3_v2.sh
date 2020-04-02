#!/bin/bash

N=$1

for i in `seq 1 $N`;
do

	# workload 3

         # Runninh independent 2 parallelism
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

        sleep 60

        # Runninh independent 2 parallelism 
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

        sleep 60

          # Runninh concurrent 2 parallelism
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

        sleep 60

        # Runninh concurrent 2 parallelism 
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000


	  # Runninh aggregate 2 parallelism
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 100000

#        sleep 60

        # Runninh aggregate 4 parallelism 
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 100000

#        sleep 60


	  # Runninh independent 4 parallelism
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

 #       sleep 60

        # Runninh independent 4 parallelism 
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

#	sleep 60

	  # Runninh concurrent 4 parallelism
 #       cd ../cloudish-cluster/
 #       bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000
#
 #       sleep 60

        # Runninh concurrent 4 parallelism 
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

#	sleep 60

	# Runninh aggregate 6 parallelism
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

#        sleep 60

        # Runninh aggregate 6 parallelism 
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000


	  # Runninh independent 6 parallelism
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

#        sleep 60

        # Runninh independent 6 parallelism 
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

#	sleep 60 
	
#	  # Runninh concurrent 6 parallelism
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000

#        sleep 60

        # Runninh concurrent 6 parallelism 
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000
#
done
