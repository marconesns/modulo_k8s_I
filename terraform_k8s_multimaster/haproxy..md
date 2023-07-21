# HAproxy

```bash
apt -y install haproxy
```

```bash
cat >> /etc/haproxy/haproxy.cfg <<EOF
frontend kubernetes-frontend
  bind *:6443
  mode tcp
  option tcplog
  default_backend kubernetes-backend
backend kubernetes-backend
  option httpchk GET /healthz
  http-check expect status 200
  mode tcp
  option ssl-hello-chk
  balance roundrobin
    server k8smaster1 192.168.122.110:6443 check fall 3 rise 2
    server k8smaster2 192.168.122.111:6443 check fall 3 rise 2

listen stats
  bind :32600
  stats enable
  stats uri /
  stats hide-version
  stats auth admin:123456    
EOF
```

```bash
vim /etc/haproxy/haproxy.cfg 
```

```bash
vim /etc/hosts
```

```bash
systemctl enable haproxy && systemctl restart haproxy
```