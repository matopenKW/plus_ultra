#!/bin/bash

# README
## https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

sudo apt-get update

sudo apt-get install -y apt-transport-https ca-certificates curl gpg

sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

## この再実行しないとうまく以下のPKGがインストールできない
sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

sudo apt install -y containerd

sudo systemctl enable containerd
sudo systemctl start containerd

# viで修正もあり
# ```
#   net.ipv4.ip_forward = 1
# ```
sudo sysctl -w net.ipv4.ip_forward=1

sudo kubeadm init

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl apply --validate=false -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml
