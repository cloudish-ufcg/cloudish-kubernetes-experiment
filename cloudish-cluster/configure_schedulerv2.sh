#!/bin/bash

#SCHEDULER=$1
SAFETY_VALUE=$1
LIMIT_OVERHEAD=$2
EXTRA_OVERHEAD=$3
SCHEDULER=$4     # priority  or slodriven


echo ""
PROMAPI=`kubectl get services --all-namespaces | grep prometheusapi | awk '{print $4}'`

echo ""
echo ">>> Configuring prometheus for scheduler"
echo ""
#cat conf/services/kube-scheduler-base.yaml | sed "s/NEWPORT/$PROMAPI_PORT/g" > conf/services/kube-scheduler.yaml
#cat conf/services/kube-scheduler-base.yaml | sed "s/SCHEDULER/$SCHEDULER/g" > conf/services/kube-scheduler-test.yaml
cat conf/services/kube-scheduler-base.yaml | sed "s/SCHEDULER/viniciusbds\/$SCHEDULER/g" | sed "s/PROMADDR/$PROMAPI:9090/g" | sed "s/OVERHEADVALUE/$EXTRA_OVERHEAD/g" | sed "s/LIMITOVERHEAD/$LIMIT_OVERHEAD/g" | sed "s/SAFETYVALUE/$SAFETY_VALUE/g" > conf/services/kube-scheduler.yaml


#cat conf/services/kube-scheduler-base.yaml | sed "s/kube-scheduler:v3.2/kube-scheduler:v3.3/g" > conf/services/kube-scheduler.yaml


cp conf/services/kube-scheduler.yaml /etc/kubernetes/manifests/
