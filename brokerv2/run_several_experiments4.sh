#!/bin/bash

N=$1

for i in `seq 1 $N`;
do
	# Runninh independent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600

	# Runninh independent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600

	# Runninh mixed workload
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free.csv 3600

        # Runninh mixed workload
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free.csv 3600

       # Runninh mixed workload
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-4-parallel-job-free.csv 3600

	 # Runninh mixed workload
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-4-parallel-job-free.csv 3600

       # Runninh mixed workload
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-6-parallel-job-free.csv 3600

	 # Runninh mixed workload
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-6-parallel-job-free.csv 3600

	 # Runninh concurrent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600

	 # Runninh concurrent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
	./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600

         # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600

         # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600

done
