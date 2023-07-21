# Exercícios Conceitos básicos

## Atividade 1: Criar um Pod

Crie um arquivo YAML chamado `pod.yaml` com as seguintes especificações:


<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  containers:
  - image: nginx
    name: nginx
```

</p>
</details>


Use o comando `kubectl create` para criar o Pod usando o arquivo YAML:

<details><summary>show</summary>
<p>


```bash
kubectl create -f pod.yaml
```

</p>
</details>

Verifique se o Pod foi criado corretamente usando o comando `kubectl get`:

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

## Atividade 2: Obter detalhes de um Pod

Use o comando `kubectl describe` para obter detalhes sobre o Pod criado anteriormente:

<details><summary>show</summary>
<p>

```bash
kubectl describe pod meu-pod
```

</p>
</details>

## Atividade 3: Editar um Pod

Use o comando `kubectl edit` para editar o Pod e adicionar uma nova anotação:

<details><summary>show</summary>
<p>

```bash
kubectl edit pod meu-pod
```

</p>
</details>

Adicione a seguinte linha abaixo de `metadata:`

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  **annotations:**
    **example.com/annotation: example**
  creationTimestamp: "2023-07-04T13:22:34Z"
  labels:
    app: nginx
  name: nginx
  namespace: default
  resourceVersion: "12532"
  uid: d486200c-c120-4202-9327-3046daed8301
spec:
  containers:
  - image: nginx
[.... Omitido .....]
```

</p>
</details>

Salve e saia do editor. Verifique se as alterações foram aplicadas usando o comando `kubectl describe`:

<details><summary>show</summary>
<p>

```bash
kubectl describe pod meu-pod
```

</p>
</details>

## Atividade 4: Criar um Deployment

Crie um arquivo YAML chamado `deployment.yaml` com as seguintes especificações:

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: meu-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: meu-app
  template:
    metadata:
      labels:
        app: meu-app
    spec:
      containers:
        - name: meu-container
          image: nginx
```

</p>
</details>

Use o comando `kubectl create` para criar o Deployment usando o arquivo YAML:

<details><summary>show</summary>
<p>

```bash
kubectl create -f deployment.yaml
```

</p>
</details>

Verifique se o Deployment foi criado corretamente usando o comando `kubectl get`:

<details><summary>show</summary>
<p>

```bash
kubectl get deployments
```

</p>
</details>

## Atividade 5: Obter detalhes de um Deployment

Use o comando `kubectl describe` para obter detalhes sobre o Deployment criado anteriormente:

<details><summary>show</summary>
<p>

```bash
kubectl describe deployment meu-deployment
```

</p>
</details>

> Essas atividades fornecem uma introdução prática ao uso dos comandos `kubectl create`, `kubectl get`, `kubectl describe` e `kubectl edit`. Explore mais opções e recursos desses comandos para aprimorar seu conhecimento.