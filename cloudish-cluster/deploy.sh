#!/bin/bash

#STRING="127.0.1.1 `hostname`"
#if [ `grep -c $STRING /etc/hosts` -lt 1 ]
#then
#    echo 127.0.1.1 `hostname` >> /etc/hosts
#fi

echo ""
echo ">>> Building infrastructure"
echo ""

kubeadm reset
kubeadm init --kubernetes-version='v1.9.1' --pod-network-cidr="10.244.0.0/16"

cp /etc/kubernetes/admin.conf $HOME/
chown $(id -u):$(id -g) $HOME/admin.conf
export KUBECONFIG=$HOME/admin.conf

sleep 10

echo ""
echo ">>> Configuring preemption"
echo ""

HOST=`ifconfig ens3 | grep "inet " | sed 's/:/ /g' | awk '{print $3}'`
cat conf/services/kube-apiserver-base.yaml | sed "s/HOST_IP/$HOST/g" > conf/services/kube-apiserver.yaml
cp conf/services/kube-apiserver.yaml /etc/kubernetes/manifests/
cp conf/services/kube-scheduler-base.yaml /etc/kubernetes/manifests/kube-scheduler.yaml

cp conf/services/kube-controller-manager.yaml /etc/kubernetes/manifests/
cp conf/services/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/

sleep 10 

systemctl restart kubelet.service
systemctl daemon-reload

sleep 60

#echo ""
#echo ">>> Taint master to be schedulable"
#echo ""
kubectl taint nodes --all node-role.kubernetes.io/master-
#kubectl taint nodes kubernetes-master dedicated:NoSchedule-


#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

# creating priority classes 
kubectl create -f conf/priority_classes/services_priority_class.yaml
#kubectl create -f conf/priority_classes/low_priority_class.yaml
#kubectl create -f conf/priority_classes/high_priority_class.yaml

kubectl create -f conf/priority_classes/free_priority_class.yaml
kubectl create -f conf/priority_classes/batch_priority_class.yaml
kubectl create -f conf/priority_classes/prod_priority_class.yaml




#echo ""
#echo ">>> Taint master to be schedulable"
#echo ""
#kubectl taint nodes --all node-role.kubernetes.io/master-
#kubectl taint nodes kubernetes-master dedicated:NoSchedule-

echo ""
echo ">>> Starting network services"
echo ""
#kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
kubectl apply -f https://docs.projectcalico.org/v2.6/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml
#kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml

sleep 60

COUNTER=`kubectl get pods --all-namespaces | grep -v NAME | awk '{print $4}' | grep -v Running | wc -l`
while [  $COUNTER -ne 0 ]; do
	sleep 1
	COUNTER=`kubectl get pods --all-namespaces | grep -v NAME | awk '{print $4}' | grep -v Running | wc -l`
done

echo ""
echo ">>> Prometheus configuration"
echo ""
kubectl create namespace prom
kubectl -n prom create serviceaccount prom-cm-adapter
kubectl -n prom create configmap prometheus --from-file=prometheus.yml=conf/prometheus/prom-cfg.yaml

echo ""
echo ">>> Creating certificates"
echo ""
cd /etc/kubernetes/pki

export PURPOSE=serving
echo '{"signing":{"default":{"expiry":"43800h","usages":["signing","key encipherment","'${PURPOSE}'"]}}}' > "${PURPOSE}-config.json"

export SERVICE_NAME=prometheus
export ALT_NAMES='"prometheus.prom","prometheus.prom.svc"'
echo '{"CN":"'${SERVICE_NAME}'","hosts":['${ALT_NAMES}'],"key":{"algo":"rsa","size":2048}}' | cfssl gencert -ca=ca.crt -ca-key=ca.key -config=serving-config.json - | cfssljson -bare apiserver

cd /root/kubernetes-examples/cloudish-cluster

echo ""
echo ">>> Lauching prometheus"
echo ""
kubectl create rolebinding prom-ext-auth-reader --role="extension-apiserver-authentication-reader" --serviceaccount=prom:prom-cm-adapter

kubectl -n prom create secret tls serving-cm-adapter --cert=/etc/kubernetes/pki/apiserver.pem --key=/etc/kubernetes/pki/apiserver-key.pem

kubectl create -f conf/prometheus/resource-lister.yaml
kubectl create -f conf/prometheus/resource-rolebinding.yaml
kubectl create -f conf/prometheus/delegator-clusterrolebinding.yaml
kubectl create rolebinding -n kube-system cm-adapter-resource-lister --role=extension-apiserver-authentication-reader --serviceaccount=prom:prom-cm-adapter

kubectl -n prom create -f conf/prometheus/prom-adapter.deployment.yaml
kubectl -n prom create service clusterip prometheus --tcp=443:6443

sleep 10

echo ""
echo ">>> Registering the prometheus API"
echo ""
BASE=`base64 --w 0 < /etc/kubernetes/pki/ca.crt`; cat conf/prometheus/cm-registration-base.yaml | sed "s/BASE64/$BASE/g" > conf/prometheus/cm-registration.yaml

kubectl apply -f conf/prometheus/cm-registration.yaml

PODNAME=`kubectl get pods -n prom | grep prometheus | awk '{print $1}'`

kubectl expose pod $PODNAME -n prom --port=9090 --name prometheusapi --type NodePort
kubectl expose pod $PODNAME -n prom --port=9091 --name pushgateway --type NodePort

kubectl get services --all-namespaces

sleep 10

echo ""
PROMAPI=`kubectl get services --all-namespaces | grep prometheusapi | awk '{print $4}'`
echo ">>> Curl prometheus API on $PROMAPI:9090"
echo ""
curl $PROMAPI:9090/api/v1/label/__name__/values

echo ""
GATEWAY=`kubectl get services --all-namespaces | grep pushgateway | awk '{print $4}'`
echo ">>> Curl pushgateway API on $GATEWAY:9090"
echo ""
curl $GATEWAY:9091/metrics

echo ""
echo ">>> Kube-watch configuration"
echo ""
kubectl create namespace kubewatch

HOSTIP=`ifconfig ens3 | grep "inet addr" | sed 's/:/ /g' | awk '{print $3}'` 
PROMAPI_PORT=`kubectl get services --all-namespaces | grep prometheusapi | awk '{print $6}' | sed 's/:/ /g' | sed 's/\// /g' | awk '{print $2}'`
GATEWAY_PORT=`kubectl get services --all-namespaces | grep pushgateway | awk '{print $6}' | sed 's/:/ /g' | sed 's/\// /g' | awk '{print $2}'`

cat conf/kubewatch/kube-watch-base.yaml | sed "s/GATEWAY_ADDR/$GATEWAY:9091/g" | sed "s/API_ADDR/$PROMAPI:9090/g" > conf/kubewatch/kube-watch.yaml

kubectl -n kubewatch create -f conf/kubewatch/kube-watch.yaml
kubectl -n kubewatch create -f conf/kubewatch/kube-watch-role.yaml

echo ""
echo ">>> Configuring prometheus for scheduler"
echo ""
#cat conf/services/kube-scheduler-base.yaml | sed "s/NEWPORT/$PROMAPI_PORT/g" > conf/services/kube-scheduler.yaml
cat conf/services/kube-scheduler-base.yaml | sed "s/PROMADDR/$PROMAPI:9090/g" > conf/services/kube-scheduler.yaml
cp conf/services/kube-scheduler.yaml /etc/kubernetes/manifests/

sleep 10

echo ""
echo ">>> Restarting services"
echo ""
systemctl restart kubelet.service
systemctl daemon-reload

sleep 10 
kubectl taint node `hostname`  dedicated=special-user:NoSchedule
