#!/bin/bash

#Instaling Docker

sudo apt-get update
sudo apt-get install -qy docker.io
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce

##Checking version:
sudo docker -v

#Instaling K8s

sudo apt-get update \
  && sudo apt-get install -y apt-transport-https \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add

echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" \
  | sudo tee -a /etc/apt/sources.list.d/kubernetes.list \
  && sudo apt-get update

sudo apt-get update \
  && sudo apt-get install -y \
  kubelet \
  kubeadm \
  kubernetes-cni

#Configurating Service

kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://docs.projectcalico.org/v3.0/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml

#Taint master node
#kubectl taint nodes --all node-role.kubernetes.io/master-
