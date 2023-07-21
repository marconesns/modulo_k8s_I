# Exercícios Controladores

== Atividade 1: Trabalhando com ReplicationController

Passo 1: Crie um arquivo de manifesto YAML para um ReplicationController que execute três réplicas de um aplicativo de exemplo.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: my-replication-controller
spec:
  replicas: 3
  selector:
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

Passo 2: Implante o ReplicationController usando o arquivo de manifesto.

<details><summary>show</summary>
<p>

```bash
kubectl apply -f replication-controller.yaml
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

Passo 4: Altere o número de réplicas para cinco e aplique a atualização no ReplicationController.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: my-replication-controller
spec:
  replicas: 5
  selector:
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

```bash
kubectl apply -f replication-controller.yaml
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

Passo 6: Exclua o ReplicationController e verifique se as réplicas foram removidas.

<details><summary>show</summary>
<p>

```bash
kubectl delete replicationcontroller my-replication-controller
kubectl get pods
```

</p>
</details>
