# Deployment

```bash
kubectl set image deployment.v1.apps/nginx-deploy nginx=nginx:1.25.1
```

```bash
kubectl apply -f deployment.yaml --record
```

```bash
kubectl rollout history deplopyment <nome do deployment>
```

```bash
kubectl annotate deployment <nome do deploy> kubernetes.io/change-cause="Deinindo a images como latest"
```

```bash
kubectl rollout history deplopyment <nome do deployment>
```

```bash
kubectl rollout undo deployment <nome> --to-revision=2
```
