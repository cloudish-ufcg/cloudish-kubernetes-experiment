#!/bin/bash

N=$1

for i in `seq 1 $N`;
do

	# workload 1

        # Runninh independent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-independent-with-port.csv 3600

        # Runninh independent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-independent-with-port.csv 3600

        # Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-time_aggregated-with-port.csv 3600 30

        # Runninh time_aggregated
 #       cd ../cloudish-cluster/
 #       bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-time_aggregated-with-port.csv 3600 30

        # Runninh concurrent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600

        # Runninh concurrent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600


        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600


        # Runninh independent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600

        # Runninh independent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600


	# Runninh concurrent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600

        # Runninh concurrent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment_b2.sh workloads/synthetic-workload5-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600


	# Runninh mixed workload
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30

        # Runninh mixed workload
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30


	# workload 4 - time_aggregated 

        # Runninh mixed workload
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload4-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-peak-with-port.csv 3600 30

        # Runninh mixed workload
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload4-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-peak-with-port.csv 3600 30

done
