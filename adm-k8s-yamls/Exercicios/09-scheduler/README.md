# Exercícios Scheduler

## Atividade 1: Scheduling Manual

Passo 1: Crie um arquivo chamado `pod.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
```

</p>
</details>

Passo 2: Salve o arquivo e execute o seguinte comando para criar o pod:

<details><summary>show</summary>
<p>

```bash
kubectl create -f pod.yaml
```

</p>
</details>

Passo 3: Verifique o estado do pod:

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

## Atividade 2: Labels e Selectors

Passo 1: Crie um arquivo chamado `deployment.yaml` e adicione o seguinte conteúdo:

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
      app: nginx-app
  template:
    metadata:
      labels:
        app: nginx-app
    spec:
      containers:
      - name: my-container
        image: nginx
```

</p>
</details>

Passo 2: Salve o arquivo e execute o seguinte comando para criar o deployment:

<details><summary>show</summary>
<p>

```bash
kubectl create -f deployment.yaml
```

</p>
</details>

Passo 3: Verifique o estado dos pods do deployment:

<details><summary>show</summary>
<p>

```bash
kubectl get pods -l app=nginx-app
```

</p>
</details>

## Atividade 3: Annotations

Passo 1: Execute o seguinte comando para adicionar uma annotation ao pod:

<details><summary>show</summary>
<p>

```bash
kubectl annotate pod my-pod description="This is my pod"
```

</p>
</details>

Passo 2: Verifique as annotations do pod:

<details><summary>show</summary>
<p>

```bash
kubectl describe pod my-pod
```

</p>
</details>

## Atividade 4: Taints e Tolerations

Passo 1: Crie um arquivo chamado `node.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Node
metadata:
  name: my-node
spec:
  taints:
  - key: my-taint
    value: my-value
    effect: NoSchedule
```

</p>
</details>

Passo 2: Salve o arquivo e execute o seguinte comando para criar o nó:

<details><summary>show</summary>
<p>

```bash
kubectl create -f node.yaml
```

</p>
</details>

Passo 3: Verifique o estado do nó:

<details><summary>show</summary>
<p>

```bash
kubectl get nodes
```

</p>
</details>

Passo 4: Crie um pod que tolera o taint definido no nó. Crie um arquivo chamado `tolerations-pod.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-tolerations-pod
spec:
  containers:
  - image: nginx
    name: nginx
  tolerations:
  - key: my-taint
    operator: "Exists"
    effect: "NoSchedule"
```

</p>
</details>

Passo 5: Salve o arquivo e execute o seguinte comando para criar o pod:

<details><summary>show</summary>
<p>

```bash
kubectl create -f tolerations-pod.yaml
```

</p>
</details>

## Atividade 5: Node Selectors e Affinity

Passo 1: Crie um arquivo chamado `node-selector-pod.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: node-selector-pod
spec:
  containers:
  - name: my-container
    image: nginx
  nodeSelector:
    disk: ssd
```

</p>
</details>

Passo 2: Salve o arquivo e execute o seguinte comando para criar o pod:

<details><summary>show</summary>
<p>

```bash
kubectl create -f node-selector-pod.yaml
```

</p>
</details>

Passo 3: Verifique o nó em que o pod foi agendado:

<details><summary>show</summary>
<p>

```bash
kubectl get pod node-selector-pod -o wide
```

</p>
</details>

> :warning: **Warning:** Nenhum node possui uma label com disk=ssd, por isso o pod está com `pending`

> :memo: **Nota:** Espero que essas atividades práticas sejam úteis para você explorar e aprimorar seu conhecimento em Kubernetes!