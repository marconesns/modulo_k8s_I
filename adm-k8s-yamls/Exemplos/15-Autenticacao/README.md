# New User:

```bash
kubectl config view
```

```bash
openssl genrsa -out <nome_user>.key 2048
```

```bash
openssl req -new -key <nome_user>.key -subj "/CN=<nome_user>" -out <nome_user>.csr
```

Editar o arquivo <nome_user>.yaml

```bash
cat <nome_user>.csr | base64 | tr -d "\n"
```

```bash
kubectl apply -f <nome_user>.yaml

```bash
kubectl get csr
```

```bash
kubectl certificate approve <nome_user>
```

```bash
kubectl get csr
```

```bash
kubectl get csr <nome_user>-csr -o jsonpath='{.status.certificate}' | base64 -d > <nome_user>.crt
```

```bash
kubectl config set-credentials <nome_user> --client-key=<nome_user>.key --client-certificate=<nome_user>.crt
```

```bash
kubectl config set-context <nome_user> --cluster=<nome_cluster> --user=<nome_user>
```

```bash
vim role.yaml

```bash
kubectl apply -f role.yaml
```

```bash
vim rolebinding.yaml
```

```bash
kubectl apply -f rolebinding.yaml
```

```bash
kubectl --context marcones get pods
```