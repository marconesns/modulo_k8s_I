# Workers

```bash
sed -i '/swap/d' /etc/fstab
```

```bash
swapoff -a
```

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

curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$CRIO_VERSION/$OS/Release.key | sudo apt-key add -
```

```bash
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key add -
```

```bash
apt update
apt install -y cri-o cri-o-runc
```

```bash
systemctl enable --now crio.service
```

```bash
apt-get install -y apt-transport-https ca-certificates curl
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

```bash
apt-get update
```

```bash
apt-get install -y kubelet kubeadm kubectl
```

```bash
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
```

```bash
apt-get update
```

```bash
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
```

```bash
systemctl enable --now kubelet
```

```bash
kubeadm join 34.218.246.132:6443 --token td73wn.8gqko1be4lvg2j4l 	--discovery-token-ca-cert-hash sha256:01b5b4c42d5daa74031d4702ebae8b42b41e109db34f1aec07b3010fa9b34d28
```