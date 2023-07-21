# Exercicos nodeName, Labels e Selectors

Exemplos práticos de como você pode usar os recursos de `nodename`, `labels` e `selectors` no Kubernetes:

## Atividade 1: Usando nodename para implantar um pod em um nó específico:

Passo 1: Você pode usar o campo `spec.nodeName` no manifesto do pod para definir em qual nó o pod deve ser implantado. Por exemplo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  nodeName: nome-do-no
  containers:
    - name: meu-container
      image: nginx
```

</p>
</details>

Isso garante que o pod será implantado apenas no nó com o nome especificado.

## Atividade 2: Usando labels e selectors para implantar um conjunto de pods:

Passo 1. Você pode atribuir labels aos seus pods e, em seguida, usar os selectors para implantar conjuntos de pods com base nessas labels. Por exemplo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod-1
  labels:
    app: minha-aplicacao
spec:
  containers:
    - name: meu-container
      image: nginx
---
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod-2
  labels:
    app: minha-aplicacao
spec:
  containers:
    - name: meu-container
      image: nginx
```

</p>
</details>

Passo 2. Verifique se os dois pods foram criados, depois escolha qualquer um e remova-o.

<details><summary>show</summary>
<p>

```bash
kubectl delete pod meu-pod-1
```

</p>
</details>

Passo 3. Confirme se o pod foi removido e recrie utilizando aplicando o arquivo yaml criado na atividade 2 passo 1.

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

## Atividade 3: Criando um Replication controller para gerenciar os pods.

Passo 1. Agora, você pode usar um seletor para implantar todos os pods com a label `app: minha-aplicacao`. Por exemplo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: meu-rc
spec:
  replicas: 2
  selector:
    matchLabels:
      app: minha-aplicacao
  template:
    metadata:
      labels:
        app: minha-aplicacao
    spec:
      containers:
        - name: meu-container
          image: nginx
```

</p>
</details>

Passo 2. Verifique se os dois pods continuam em execução, depois escolha qualquer um e remova-o.

<details><summary>show</summary>
<p>

```bash
kubectl delete pod meu-pod-1
```

</p>
</details>

Dessa forma, o Replication Controller irá garantir que sempre haja dois pods com a label `app: minha-aplicacao` em execução.

> :memo: **Nota:** Esses são apenas alguns exemplos de como você pode usar `nodename`, `labels` e `selectors` no Kubernetes. Esses recursos são poderosos para controlar a implantação e a seleção de recursos dentro do seu cluster Kubernetes.