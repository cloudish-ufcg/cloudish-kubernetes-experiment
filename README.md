# Kubernetes experiments

To install the dependencies and configuring the environment to create the cluster (It includes Go, kubeadm and environment variables): 

`./cloudish-cluster/install.sh`

To create and configure a kubernetes cluster with cloudish scheduler, kube-watch and prometheus:

`./cloudish-cluster/deploy.sh`


## Broker

After infrastructure is ready, we can submit a workload to be allocated during a certain period (seconds) of experiment.

`./broker/run_experiment.sh <workload-file> <duration>`

Example:

`./broker/run_experiment.sh synthetic-workload-20hosts-5min_onlyprod.csv 3600`

The results of experiment (files with informations about allocation, waiting time and termination) will be saved in `/data` into broker folder.


