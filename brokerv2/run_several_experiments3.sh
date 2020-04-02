#!/bin/bash

N=$1

for i in `seq 1 $N`;
do
	# Runninh independent

	 # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-no-contention-independent.csv 3600

	cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-no-contention-independent.csv 3600


	cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-no-contention-concurrent.csv 3600

        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-no-contention-concurrent.csv 3600


	cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-no-contention-time_aggregated.csv 3600

        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-no-contention-time_aggregated.csv 3600

       # echo Running independent experiment $i

       # # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
 	bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600
       # ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-1-replicas-all-independent.csv 3600
	#./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-independent.csv 3600

	 # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600
#       # ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-1-replicas-all-independent.csv 3600
#        #./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-independent.csv 3600
#
       # # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-concurrent.csv 3600
       # ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-1-replicas-all-independent.csv 3600
        #./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-independent.csv 3600

 #        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
 #       cd ../cloudish-cluster/
 #       #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
 #       bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-concurrent.csv 3600
 #      # ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-1-replicas-all-independent.csv 3600
#

 # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free.csv 3600

 # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
 #       cd ../cloudish-cluster/
 #       #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
 #       bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-2-parallel-job-free.csv 3600


# RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-4-parallel-job-free.csv 3600

 # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
 #       cd ../cloudish-cluster/
 #       #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
 #       bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-4-parallel-job-free.csv 3600


# RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-6-parallel-job-free.csv 3600

 # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
 #       cd ../cloudish-cluster/
 #       #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
 #       bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-deploy-independent-6-parallel-job-free.csv 3600
#
	# RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600
       # ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-1-replicas-all-independent.csv 3600
        #./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-independent.csv 3600

         # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
 #       cd ../cloudish-cluster/
 #       #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
 #       bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
 #       sleep 10
 #       ./prepara_ambiente.sh
 #       cd ../brokerv2/
 #       ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-time_aggregated.csv 3600
       # ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-1-replicas-all-independent.csv 3600
        #./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-independent.csv 3600


        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
        cd ../cloudish-cluster/
        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.4
        sleep 10
        ./prepara_ambiente.sh
        cd ../brokerv2/
        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-independent.csv 3600

        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-independent.csv 3600
#

        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-priority-scheduler:v0.2.1
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-time_aggregated.csv 3600
#
         # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        #bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.3
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-time_aggregated.csv 3600


#	 echo Running time aggregate experiment $i
#
#        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-time_aggregated.csv 3600


 #       # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 10
#       cd ../cloudish-cluster/
#       bash configure_schedulerv2.sh 10.0 true 0.0 kube-scheduler:v9.7.9.0
#       sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-4-replicas-all-time_aggregated.csv 3600

#	 echo Running concurrent experiment $i
#
#        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 30
#        cd ../cloudish-cluster/
#        bash configure_schedulerv2.sh 30.0 true 0.0 kube-scheduler:v9.7.9.0
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600
#
#
#        # RUNNINIG THE QoS-DRIVEN SCHEDULER with safety margin 10
#        cd ../cloudish-cluster/
#        bash configure_schedulerv2.sh 10.0 true 0.0 kube-scheduler:v9.7.9.0
#        sleep 10
#        ./prepara_ambiente.sh
#        cd ../brokerv2/
#        ./run_experiment.sh workloads/synthetic-workload1-5hosts-10pods-per-host-multiple-controllers-2-replicas-all-concurrent.csv 3600
#
done

