#!/bin/bash 

INPUT_BASE=`echo $1 | sed 's/.csv//g'`
OUTPUT_BASE=`date +%Y%m%d"_"%H%M%S`"_"$INPUT_BASE

mkdir data/$OUTPUT_BASE

go run broker.go $1

KWPOD=`kubectl get pods -n kubewatch | grep -v NAME | awk '{print $1}'`

sleep 10

COUNTER=`kubectl get deploy | grep -v resources | wc -l`
while [  $COUNTER -ne 0 ]; do
	sleep 1
	COUNTER=`kubectl get deploy | grep -v resources | wc -l`
done

sleep 10

kubectl cp kubewatch/$KWPOD:/home/allocation.dat data/$OUTPUT_BASE/
kubectl cp kubewatch/$KWPOD:/home/termination.dat data/$OUTPUT_BASE/
kubectl cp kubewatch/$KWPOD:/home/waiting.dat data/$OUTPUT_BASE/

sleep 1

kubectl cp /dev/null kubewatch/$KWPOD:/home/allocation.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/termination.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/waiting.dat
