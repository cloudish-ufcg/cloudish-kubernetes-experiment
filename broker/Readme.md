# Tutorial

In order to execute the simulation it is necessary to insert the data in the configuration file(commands.cfg).
```
Time EventType DeployName CpuReq MemReq PriorityClass
10 create nginx 1.0 100Mi high-priority-class
40 delete nginx
```

Then, run the shell script file:
```
$ sh k8s-broker.sh <kube-watch pod name>
```

After the simulation is finished, the results will be in the output directory.
