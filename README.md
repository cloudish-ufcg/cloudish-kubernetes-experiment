# Kubernetes PoC experiments - SLO-driven scheduling

To install the dependencies and configure the environment (including Go and kubeadm env variables) to create the cluster, execute this command in the master and worker nodes:

`$# ./cloudish-cluster/install.sh`

To configure and deploy a kubernetes cluster with the SLO-driven scheduler, kube-watch and prometheus:

`$# ./cloudish-cluster/deploy.sh`

P.S. If you want to use a different image of kube watch or kube scheduler, you can edit base files (`cloudish-cluster/conf/kubewatch/kube-watch-base.yaml` and `cloudish-cluster/conf/services/kube-scheduler-base.yaml` respectively) before running the `deploy.sh` script.

## Broker

After deploying the cluster infrastructure, we can submit a workload to be allocated during a certain period of experiment (in seconds) using the cloudish broker:

`$# ./broker/run_experiment.sh <workload-file> <duration>`

Example for 1-hour experiment:

`$# ./broker/run_experiment.sh synthetic-workload-20hosts-5min_onlyprod.csv 3600`

We consider that all commands are executed as root, so configuration files are saved in the `/root` directory.

### Experiment results file format

The experiment results will be saved in `/data` sub-directory of the `broker/` directory in CSV format. Each experiment generates three result files with information about allocation, waiting time and termination of pods and deployments. The file formats are explained as follows.

#### Allocation data (`allocation.dat`):

- `timestamp`: Refers to timestamp of allocation event.
- `podName`: Name of allocated pod.
- `controllerName`: Name of deployment to which the pod is associated.
- `hostName`: The host where the pod was allocated.
- `waitTime`: How long the pod has waited before start running.

#### Waiting data (`waiting.dat`):

- `timestamp`: Refers to timestamp of arrival event.
- `podName`: Name of pod.
- `controllerName`: Name of deployment to which the pod is associated.

#### Termination data (`termination.dat`):

- `timestamp`: Refers to timestamp of termination event.
- `podName`: Name of terminated pod.
- `controllerName`: Name of deployment to which the pod is associated.
- `runtime`: How long the pod has run before termination.
