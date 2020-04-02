#!/bin/bash

N=$1

for i in `seq 1 $N`;
do

	# workload 3

	# running 10 pods per host - batch 90%

	#synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv

	# Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port.csv 3600 30 50000

#        sleep 60

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 50000
#
#        sleep 60

#synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000
#	./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free-with-port-from-aggregated.csv 3600 30 50000

#        sleep 60

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000
#	./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free-with-port-from-aggregated.csv 3600 30 50000

#	sleep 60 

	  # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-2-parallel-job-free-with-port-from-aggregated.csv 3600 30 50000

#        sleep 60

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-concurrent-2-parallel-job-free-with-port-from-aggregated.csv 3600 30 50000

#        sleep 60


	  # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 100000

#        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 100000

        sleep 60

	   # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000
        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port.csv 3600 30 100000

        sleep 60

        # Runninh 2 jobs
        cd ../cloudish-cluster/
        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 100000
        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port.csv 3600 30 100000

        sleep 60

	          # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 150000
#        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port.csv 3600 30 150000

#        sleep 60

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port-diff-task-duration.csv 3600 30 150000
#        #./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port.csv 3600 30 150000

#        sleep 60




        # Runninh 4 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000

#        sleep 60

        # Runninh 4 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000


        # Runninh 6jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000

#        sleep 60

        # Runninh 6 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port-diff-task-duration.csv 3600 30 50000

#        sleep 60

	# running 20 pods per host - batch 90%

	#synthetic-workload3-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv

	# Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 50000

#        sleep 60

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v2-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 50000

#        sleep 60

	 # running 10 pods per host - batch 95%

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v3-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 50000

#        sleep 60

        # Runninh 2 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v3-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-2-parallel-job-free-with-port.csv 3600 30 50000

#	sleep 60 

     	 # Runninh 4 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v3-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port.csv 3600 30 50000

#        sleep 60

        # Runninh 4 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v3-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-4-parallel-job-free-with-port.csv 3600 30 50000
#
#	sleep 60

	 # Runninh 6 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v3-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port.csv 3600 30 50000

 #       sleep 60

        # Runninh 6 jobs
#        cd ../cloudish-cluster/
#        bash configure_schedulervGiovanni.sh 30.0 true 0.0 kube-scheduler:v0.7.5 30
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload3-v3-5hosts-20pods-per-host-multiple-controllers-2-replicas-deploy-time_aggregated-6-parallel-job-free-with-port.csv 3600 30 50000
#
#	sleep 60
done
