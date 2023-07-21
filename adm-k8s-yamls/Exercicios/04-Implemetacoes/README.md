# Exercícios Implementações

## Atividade 1: Criação de um Deployment:

Passo 1: Crie um Deployment chamado "my-deployment" com 3 réplicas de um contêiner chamado "my-container" usando a imagem "nginx:1.24.0".

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: nginx:1.24.0
```

</p>
</details>

Passo 2: Atualize o Deployment "my-deployment" para usar a imagem "nginx:1.25.1".

<details><summary>show</summary>
<p>

```bash
kubectl set image deployment/my-deployment my-container=nginx:1.25.1
```

</p>
</details>

Passo 3: Rollover com histórico, Rolar o Deployment "my-deployment" para a próxima revisão usando um histórico de revisões.

<details><summary>show</summary>
<p>

```bash
kubectl rollout history deployment/my-deployment
kubectl rollout undo deployment/my-deployment --to-revision=<revision-number>
```

</p>
</details>

Passo 4: Rollback de um Deployment. Reverter o Deployment "my-deployment" para a revisão anterior.

<details><summary>show</summary>
<p>

```bash
kubectl rollout undo deployment/my-deployment
```

</p>
</details>

Passo 5: Pausar o Deployment "my-deployment" para interromper a atualização.

<details><summary>show</summary>
<p>

```bash
kubectl rollout pause deployment/my-deployment
```

</p>
</details>

Passo 6: Retomar o Deployment "my-deployment" após a pausa.

<details><summary>show</summary>
<p>

```bash
kubectl rollout resume deployment/my-deployment
```

</p>
</details>

Passo 7: Remova o Deployment chamado "my-deployment" do cluster.

<details><summary>show</summary>
<p>

```bash
kubectl delete deployment my-deployment
```

</p>
</details>

> Lembre-se de substituir os valores como nomes de Deployment, contêineres, imagens e revisões pelos valores relevantes do seu ambiente. Esses exemplos devem ajudar você a praticar a manipulação básica de Deployments no Kubernetes.