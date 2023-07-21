# Exercícios ReplicaSet

## Atividade 1: Utilizando as tecnicas de criação de um ReplicaSet

Passo 1. Crie um arquivo de manifesto YAML para um ReplicaSet que execute duas réplicas de um aplicativo de exemplo.

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replica-set
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app-container
        image: nginx:1.14.0
```

</p>
</details>

Passo 2: Implante o ReplicaSet usando o arquivo de manifesto.

<details><summary>show</summary>
<p>

```bash
kubectl apply -f replica-set.yaml
```

</p>
</details>

Passo 3: Verifique se as réplicas estão em execução e funcionando corretamente.

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Passo 4: Altere o número de réplicas para quatro e aplique a atualização no ReplicaSet.

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replica-set
spec:
  replicas: 4
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app-container
        image: nginx:1.14.0
```

```bash
kubectl apply -f replica-set.yaml
```

</p>
</details>

Passo 5: Verifique se as novas réplicas foram criadas e estão em execução.

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Passo 6: Faça uma atualização no template de pod do ReplicaSet, alterando a imagem usada pelo aplicativo, e aplique a atualização.

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replica-set
spec:
  replicas: 4
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app-container
        image: nginx:1.15.1
```

```bash
kubectl apply -f replica-set.yaml
```

</p>
</details>

Passo 7: Verifique se as réplicas foram atualizadas com a nova imagem.

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Passo 8: Exclua o ReplicaSet e verifique se as réplicas foram removidas.

<details><summary>show</summary>
<p>

```bash
kubectl delete replicaset my-replica-set
kubectl get pods
```

</p>
</details>

## Atividade 2: Escalando e gerenciando réplicas

Passo 1: Crie um arquivo de manifesto YAML para um ReplicaSet ou ReplicationController com um aplicativo de exemplo.

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: my-replica-set
spec:
  replicas: 2
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-app-container
        image: nginx
```

</p>
</details>

Passo 2: Implante o ReplicaSet ou ReplicationController usando o arquivo de manifesto.

<details><summary>show</summary>
<p>

```bash
kubectl apply -f replica.yaml
```

</p>
</details>

Passo 3: Use os comandos do Kubernetes para verificar o número de réplicas em execução.

<details><summary>show</summary>
<p>

```bash
kubectl get replicasets
kubectl get pods
```

</p>
</details>

Passo 4: Escalone manualmente o número de réplicas para três usando os comandos do Kubernetes.

<details><summary>show</summary>
<p>

```bash
kubectl scale replicaset my-replica-set --replicas=3
kubectl get replicasets
kubectl get pods
```

</p>
</details>

Passo 5: Verifique se as novas réplicas foram criadas e estão em execução.

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Passo 6: Exclua o ReplicaSet e verifique se as réplicas foram removidas.

<details><summary>show</summary>
<p>

```bash
kubectl delete replicaset my-replica-set
kubectl get pods
```

</p>
</details>

> Esses exemplos práticos devem ajudar você a experimentar e compreender melhor como usar o ReplicationController e o ReplicaSet no Kubernetes. Lembre-se de adaptar os nomes dos arquivos e recursos conforme necessário e consulte a documentação oficial do Kubernetes para obter mais detalhes sobre cada recurso.


