#!/bin/bash

N=$1

for i in `seq 1 $N`;
do
	#workload 3

	# Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 130000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 130000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 130000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 130000

	sleep 60

	# workload 4

	# Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-from3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-peak-with-port-diff-task-duration.csv 3600 30 130000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-from3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-peak-with-port-diff-task-duration.csv 3600 30 130000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-from3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-peak-with-port.csv 3600 30 130000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-from3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-peak-with-port.csv 3600 30 130000

done
