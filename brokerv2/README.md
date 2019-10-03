## Broker v2

This is a evolution of [broker](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/blob/support-multiple-controllers/broker/broker.go)
to support multiple controllers. The main diference is that the this broker receives a workload that contains, besides all the data that was already needed,
the **kind of controller**, the **number of replicas** (if the task is a deployment) **or paralelism** (if is a job), the **number of completions** (for the case of job)
and the **qosMeasuring** (independent, concurrent, time_aggregated or task_aggregated)

[see an example](https://github.com/cloudish-ufcg/cloudish-kubernetes-experiment/blob/support-multiple-controllers/brokerv2/input.example)

## How to use

After deploying the cluster infrastructure, we can submit a workload to be allocated during a certain period of experiment (in seconds) using the cloudish broker:

`$# ./brokerv2/run_experiment.sh <workload-file> <duration>`

Example for 1-hour experiment:

`$# ./brokerv2/run_experiment.sh synthetic-workload-20hosts-5min_onlyprod.csv 3600`

We consider that all commands are executed as root, so configuration files are saved in the `/root` directory.

### Experiment results file format

The experiment results will be saved in `/data` sub-directory of the `brokerv2/` directory in CSV format. Each experiment generates five result files with information about allocation, waiting time and termination of pods and deployments. The file formats are explained as follows.

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

#### Starting data (`starting.dat`):

- `timestamp`: Refers to timestamp of termination event.
- `podName`: Name of allocated pod.
- `controllerName`: Name of deployment to which the pod is associated.
- `hostName`: The host where the pod was allocated.
- `overhead`: The overhead of allocation, i.e. time between the scheduling decision and the moment when the pod was started.


#### Periods data (`periods.dat`):

- `podName`: Name of pod.
- `selectingPeriod` : The period that the scheduler algorithm takes to sort the pending queue and select the first pod.
- `schedulingPeriod` : The period that the scheduler try schedule the first pod of the pending queue without preempt other one.
- `preemptingPeriod` : The period that the scheduler try preempt running pods to make room to the new pod. When this field is empty, it means that the preemptPeriod was not need be calculed because de pod was scheduled directly.
