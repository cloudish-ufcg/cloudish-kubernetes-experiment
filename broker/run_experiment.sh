#!/bin/bash 

INPUT_BASE=`echo $1 | sed 's/.csv//g'`
OUTPUT_BASE=`date +%Y%m%d"_"%H%M%S`"_"$INPUT_BASE

mkdir data/$OUTPUT_BASE

go run broker.go $1

# copy files


KWPOD=`kubectl get pods -n kubewatch | grep -v NAME | awk '{print $1}'`

kubectl cp kubewatch/$KWPOD:/home/allocation.dat data/$OUTPUT_BASE/
kubectl cp kubewatch/$KWPOD:/home/termination.dat data/$OUTPUT_BASE/
kubectl cp kubewatch/$KWPOD:/home/waiting.dat data/$OUTPUT_BASE/

sleep 1

kubectl cp /dev/null kubewatch/$KWPOD:/home/allocation.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/termination.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/waiting.dat
