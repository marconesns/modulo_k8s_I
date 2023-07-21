# Token

certificado 

```
jq -R 'split(".") | select(length > 0) | .[0],.[1] | @base64d | fromjson' <<< eyJhbGciOiJSUzI1....
```


JWT[https://jwt.io/]

```
kubectl create sa erick
```

```
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: erick
  annotations:
    kubernetes.io/service-account.name: erick
type: kubernetes.io/service-account-token
EOF
```
``` 
kubectl get secret/erick -o yaml
```

```
kubectl describe secrets/erick
```

```
kubectl get secrets/erick -o jsonpath={.data.token} | base64 --decode
```

```
export token=$(kubectl get secrets/erick -o jsonpath={.data.token} | base64 --decode)
```

```
echo $token
```

```
kubectl config set-credentials admin --token=$token
```

```
kubectl config view
```

```
kubectl config set-context new-context --cluster=<nome do cluster> --user=admin
```

```
kubectl config view
```

```
kubectl create clusterrolebinding admin-user-binding --clusterrole cluster-admin --serviceaccount default:erick
```

```
kubectl config use-context new-context
```

```
kubectl cluster-info
```

```
curl -kv https://192.168.39.34:8443/api/v1/namespaces --header "Authorization: Bearer $token" --cacert ca.crt
```