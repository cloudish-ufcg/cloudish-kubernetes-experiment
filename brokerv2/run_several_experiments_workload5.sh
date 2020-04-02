#!/bin/bash

N=$1

for i in `seq 1 $N`;
do

	# workload 5

       # Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 65000

#	sleep 60

        # Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 65000



       # Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 75000

#        sleep 60

        # Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 75000

#	sleep 60
	
	# Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 50000

#        sleep 60

        # Runninh time_aggregated
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 50000


        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 10000

        sleep 60

        # Runninh time_aggregated
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600 30 10000


        # Runninh independent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600 30 50000

#        sleep 60

        # Runninh independent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600 30 50000

#	sleep 60 

	# Runninh concurrent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600 30 50000

#        sleep 60

        # Runninh concurrent
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload5-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600 30 50000

#	sleep 60
done
