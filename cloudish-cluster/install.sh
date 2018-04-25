#!/bin/bash

# Install docker
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install apt-transport-https  ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu    $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce

# Install kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl kubernetes-cni

# Install go
sudo apt-get update
sudo apt-get -y upgrade
wget https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz
sudo tar -xvf go1.9.4.linux-amd64.tar.gz
sudo mv go /usr/local

# edit .profile
export GOROOT=/usr/local/go
export GOPATH=/usr/share/go/bin
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
source ~/.profile
echo $PATH
