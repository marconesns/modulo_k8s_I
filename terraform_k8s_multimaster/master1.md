# Master 1

```bash
sed -i '/swap/d' /etc/fstab
swapoff -a
----

```bash
cat <<EOF | sudo tee /etc/modules-load.d/crio.conf
overlay
br_netfilter
EOF
```

```bash
modprobe overlay
modprobe br_netfilter
```

```bash
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
```

```bash
sysctl --system
```

```bash
OS=xUbuntu_20.04
CRIO_VERSION=1.27
```

```bash
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
```

```bash
echo "deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$CRIO_VERSION/$OS/ /"|sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION.list
```

```bash
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | sudo apt-key add -
```

```bash
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key add -
```

```bash
apt update
```

```bash
apt install -y cri-o cri-o-runc
```

```bash
systemctl enable crio.service
systemctl start crio.service
```

```bash
apt-get install -y apt-transport-https ca-certificates curl
```

```bash
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
```

```bash
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

```bash
sudo apt-get update
```

```bash
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
```

```bash
systemctl enable --now kubelet
```

```bash
kubeadm config images pull
```

```bash
kubeadm init --control-plane-endpoint="34.218.246.132:6443" --upload-certs --apiserver-advertise-address=172.16.1.177
```