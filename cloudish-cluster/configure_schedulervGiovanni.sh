#!/bin/bash

#SCHEDULER=$1
SAFETY_VALUE=$1
LIMIT_OVERHEAD=$2
EXTRA_OVERHEAD=$3
SCHEDULER=$4     # priority  or slodriven
MIN_RUNNING_VALUE=$5


echo ""
PROMAPI=`kubectl get services --all-namespaces | grep prometheusapi | awk '{print $4}'`

echo ""
echo ">>> Configuring prometheus for scheduler"
echo ""
cat conf/services/kube-scheduler-base.yaml | sed "s/SCHEDULER/giovannifs\/$SCHEDULER/g" | sed "s/PROMADDR/$PROMAPI:9090/g" | sed "s/OVERHEADVALUE/$EXTRA_OVERHEAD/g" | sed "s/LIMITOVERHEAD/$LIMIT_OVERHEAD/g" | sed "s/SAFETYVALUE/$SAFETY_VALUE/g"  | sed "s/MINRUNNINGTIMEVALUE/$MIN_RUNNING_VALUE/g" > conf/services/kube-scheduler.yaml



cp conf/services/kube-scheduler.yaml /etc/kubernetes/manifests/
