#!/bin/bash

echo "> reiniciando o sistema"
systemctl restart kubelet.service
systemctl daemon-reload

sleep 10

echo "> deletando o deployment kubewatch"
kubectl delete deployment -n kubewatch kube-watch
echo
sleep 5

echo "> liberando a alocacao no node master"
#kubectl taint node kubemaster-sched-config dedicated:NoSchedule-
kubectl taint node `hostname` dedicated:NoSchedule-
echo
sleep 5

echo "> verificando se foi liberado (espera-se que esteja <none>)"
#kubectl describe node kubemaster-sched-config | grep Taints
kubectl describe node `hostname` | grep Taints
echo
sleep 5

echo "> deletando o pod do prometheus (para zerar as metricas armazenadas)"
PODNAME=`kubectl get pods -n prom | grep prometheus | awk '{print $1}'`
kubectl delete pod -n prom $PODNAME

sleep 5

echo "> deletando o pod do scheduler"
SCHEPODNAME=`kubectl get pods -n kube-system | grep kube-scheduler | awk '{print $1}'`
kubectl delete pod -n kube-system $SCHEPODNAME

sleep 10

echo "> criando o deployment kubewatch"
kubectl -n kubewatch create -f conf/kubewatch/kube-watch.yaml
echo
sleep 10

echo "> verificando se o pod do kubewatch esta rodando"
kubectl get pods -n kubewatch
echo
sleep 5

echo "> restringindo a alocacao no node master"
kubectl taint node `hostname`  dedicated=special-user:NoSchedule
echo
sleep 5

echo "> verificando se foi bloqueado (espera-se que nao esteja <none>)"
#kubectl describe node kubemaster-sched-config | grep Taints
kubectl describe node `hostname` | grep Taints
