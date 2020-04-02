#!/bin/bash

N=$1

for i in `seq 1 $N`;
do

	# workload 5

       # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 65000

	sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 65000

	sleep 60 

	 # workload 6

       # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload6-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated-with-two-peaks.csv 3600 30 65000

        sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload6-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated-with-two-peaks.csv 3600 30 65000

	sleep 60 


	 # workload 4 extended - 4 parallel tasks

       	# Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-extended-peak-with-port.csv 3600 30 65000

        sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-extended-peak-with-port.csv 3600 30 65000

        sleep 60

	 # workload 4 - 4 parallel tasks

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-peak-with-port.csv 3600 30 65000

        sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-peak-with-port.csv 3600 30 65000

        sleep 60

	 # workload 4 extended - 6 parallel tasks

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-extended-peak-with-port.csv 3600 30 65000

        sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-extended-peak-with-port.csv 3600 30 65000

        sleep 60

         # workload 4 - 6 parallel tasks

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-peak-with-port.csv 3600 30 65000

        sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload4-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-peak-with-port.csv 3600 30 65000

        sleep 60



        # Runninh independent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600 30 65000

	sleep 60

       # # Runninh independent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600 30 65000

	sleep 60

        # Runninh concurrent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600 30 65000

	sleep 60

        # Runninh concurrent
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600 30 65000

done
