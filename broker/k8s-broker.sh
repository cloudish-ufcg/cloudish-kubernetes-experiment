#!/bin/bash

NOW=0

POD=$1

while read -r line; do 
set -- $line

if [ $1 != $NOW ]; then
DIFF=`echo "$1 - $NOW" | bc`
echo "Wait for next event in $DIFF seconds."
NOW=$1
sleep $DIFF
fi

if [ "$2" =  "create" ]; then
echo "Creating $3 with CPU $4, Memory $5, and priority $6 on time $NOW!"
sed -e 's/$NAME/'$3'/; s/$CPU/'$4'/; s/$MEM/'$5'/; s/$PRIORITY/'$6'/' deploy.yaml > submit_$3.yaml
kubectl create -f submit_$3.yaml

elif [ "$2" = "delete" ]; then 
echo "Deleting $3! on time $NOW!"
kubectl delete -f submit_$3.yaml
rm submit_$3.yaml

else 
echo "Do nothing!"

fi
 
done < command.cfg

echo "Copying results file of $POD."

kubectl cp $POD:home output
