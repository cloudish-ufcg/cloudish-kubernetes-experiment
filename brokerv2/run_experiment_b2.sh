#!/bin/bash
INPUT_FILE=$1
DURATION=$2
#SERVICE_RATE_ATTACK=$3

INPUT_BASE=`basename -- $INPUT_FILE | sed 's/.csv//g'`
OUTPUT_BASE=`date +%Y%m%d"_"%H%M%S`"_"$INPUT_BASE

mkdir data/$OUTPUT_BASE


#cp /dev/null /home/serviceapplication.dat


#go run brokerv2.go $INPUT_FILE $DURATION
go run b2.go $INPUT_FILE $DURATION 

KWPOD=`kubectl get pods -n kubewatch | grep -v NAME | awk '{print $1}'`

sleep 10

AGGR_TIME=0
COUNTER=`kubectl get deploy | grep -v resources | wc -l`
MAX_DURATION=240
while [  $COUNTER -ne 0 ]; do
        sleep 1
        AGGR_TIME=$((AGGR_TIME+1))
        COUNTER=`kubectl get deploy | grep -v resources | wc -l`
        if [ $AGGR_TIME -gt $MAX_DURATION ]
        then
                echo "Deleting all deployments from default namespace"
                kubectl delete deployment --all --namespace=default
                #kubectl delete services --all --namespace=default
		kubectl delete jobs --all --namespace=default
        fi
done

sleep 10
kubectl cp kubewatch/$KWPOD:/home/allocation.dat data/$OUTPUT_BASE/allocation.dat
kubectl cp kubewatch/$KWPOD:/home/termination.dat data/$OUTPUT_BASE/termination.dat
kubectl cp kubewatch/$KWPOD:/home/waiting.dat data/$OUTPUT_BASE/waiting.dat
kubectl cp kubewatch/$KWPOD:/home/starting.dat data/$OUTPUT_BASE/starting.dat
kubectl cp kubewatch/$KWPOD:/home/periods.dat data/$OUTPUT_BASE/periods.dat
#cp /home/serviceapplication.dat data/$OUTPUT_BASE/serviceapplication.dat

sleep 1
kubectl cp /dev/null kubewatch/$KWPOD:/home/allocation.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/termination.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/waiting.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/starting.dat
kubectl cp /dev/null kubewatch/$KWPOD:/home/periods.dat

#cp /dev/null /home/serviceapplication.dat
