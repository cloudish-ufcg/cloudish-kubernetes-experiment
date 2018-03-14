#!/bin/bash

# Building infrastructure

kubeadm reset
kubeadm init --kubernetes-version='v1.9.1'

cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf

kubectl taint nodes --all node-role.kubernetes.io/master- 

kubectl apply -f https://docs.projectcalico.org/v2.5/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml 

sleep 60

COUNTER=`kubectl get pods --all-namespaces | grep -v NAME | awk '{print $4}' | grep -v Running | wc -l`
echo $COUNTER
while [  $COUNTER -ne 0 ]; do
	sleep 1
	COUNTER=`kubectl get pods --all-namespaces | grep -v NAME | awk '{print $4}' | grep -v Running | wc -l`
done

# Prometheus configuration

kubectl create namespace prom
kubectl -n prom create serviceaccount prom-cm-adapter
kubectl -n prom create configmap prometheus --from-file=prometheus.yml=prom-cfg-pg.yaml

# Creating certificates

cd /etc/kubernetes/pki

export PURPOSE=serving
echo '{"signing":{"default":{"expiry":"43800h","usages":["signing","key encipherment","'${PURPOSE}'"]}}}' > "${PURPOSE}-config.json"

export SERVICE_NAME=prometheus
export ALT_NAMES='"prometheus.prom","prometheus.prom.svc"'
echo '{"CN":"'${SERVICE_NAME}'","hosts":['${ALT_NAMES}'],"key":{"algo":"rsa","size":2048}}' | cfssl gencert -ca=ca.crt -ca-key=ca.key -config=serving-config.json - | cfssljson -bare apiserver

cd /root/kubernetes-examples/prometheus-adapter

kubectl create rolebinding prom-ext-auth-reader --role="extension-apiserver-authentication-reader" --serviceaccount=prom:prom-cm-adapter

kubectl -n prom create secret tls serving-cm-adapter --cert=/etc/kubernetes/pki/apiserver.pem --key=/etc/kubernetes/pki/apiserver-key.pem

kubectl create -f resource-lister.yaml
kubectl create -f resource-rolebinding.yaml
kubectl create -f delegator-clusterrolebinding.yaml
kubectl create rolebinding -n kube-system cm-adapter-resource-lister --role=extension-apiserver-authentication-reader --serviceaccount=prom:prom-cm-adapter

# Launching the deployment

kubectl -n prom create -f prom-adapter.deployment.yaml
kubectl -n prom create service clusterip prometheus --tcp=443:6443

PODNAME=`kubectl get pods -n prom | grep prometheus | awk '{print $1}'`

kubectl expose pod $PODNAME -n prom --port=9090 --target-port=9090 --name prometheusapi
kubectl expose pod $PODNAME -n prom --port=9091 --target-port=9091 --name pushgateway

# Registering the prometheus API

BASE=`base64 --w 0 < /etc/kubernetes/pki/ca.crt`; cat cm-registration-base.yaml | sed "s/BASE64/$BASE/g" > cm-registration.yaml

kubectl apply -f cm-registration.yaml

kubectl get services --all-namespaces

sleep 15

PROMAPI=`kubectl get services --all-namespaces | grep prometheusapi | awk '{print $4}'`

curl $PROMAPI:9090/api/v1/label/__name__/values

GATEWAY=`kubectl get services --all-namespaces | grep pushgateway | awk '{print $4}'`

curl $GATEWAY:9091/metrics


