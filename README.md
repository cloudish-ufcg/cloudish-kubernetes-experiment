# Kuberbentes experiments

To install the dependencies and configuring the environment to create the cluster (It includes Go, kubeadm and environment variables): 

`$# ./cloudish-cluster/install.sh`

To create and configure a kubernetes cluster with cloudish scheduler, kube-watch and prometheus:

`$# ./cloudish-cluster/deploy.sh`


P.S. If you want to use a different image of kube watch or kube scheduler, you can edit base files (`cloudish-cluster/conf/kubewatch/kube-watch-base.yaml` and `cloudish-cluster/conf/services/kube-scheduler-base.yaml` respectively) before run deploy command.


## Broker

After infrastructure is ready, we can submit a workload to be allocated during a certain period (seconds) of experiment.

`$# ./broker/run_experiment.sh <workload-file> <duration>`

Example:

`$# ./broker/run_experiment.sh synthetic-workload-20hosts-5min_onlyprod.csv 3600`


P.S. We consider that all commands are executed as root, so admin.conf file is present in `/root` directory.

The results of experiment (files with informations about allocation, waiting time and termination) will be saved in `/data` into broker folder.

### Allocation data:

`timestamp, podName, controllerName, hostName, waitTime`

Timestamp: Refers to timestamp of allocation event.\
podName: Name of allocated pod.\
controllerName: Name of deployment to which the pod is associated.\
hostName: The host where the pod was allocated.\
waitTime: How long the pod has waited before start running.

### Waiting data:

`timestamp, podName, controllerName`

Timestamp: Refers to timestamp of arrival event.\
podName: Name of pod.\
controllerName: Name of deployment to which the pod is associated.

### Termination data:


`timestamp, podName, controllerName, runtime`

Timestamp: Refers to timestamp of termination event.\
podName: Name of terminated pod.\
controllerName: Name of deployment to which the pod is associated.\
runtime: How long the pod has run before termination.
