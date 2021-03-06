#!/bin/bash

# Install docker
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
sudo apt-get install apt-transport-https  ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu    $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce=18.03.0~ce-0~ubuntu

# Install kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install kubelet=1.9.1-00 kubeadm=1.9.1-00 kubectl=1.9.1-00 kubernetes-cni

# Install go
wget https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz
sudo tar -xvf go1.9.4.linux-amd64.tar.gz
sudo mv go /usr/local

# Install gcc
apt install gcc build-essential


# Configuring go paths (puth this in .profile)
export GOROOT=/usr/local/go
export GOPATH=/usr/share/go/bin
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

export KUBECONFIG=$HOME/admin.conf
 
# Install go packages
go get -u github.com/cloudflare/cfssl/cmd/cfssl
go get -u github.com/cloudflare/cfssl/cmd/cfssljson



