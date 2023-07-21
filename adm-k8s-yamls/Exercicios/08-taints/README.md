# Exercícios Taints e Tolerations

## Atividade 1: Configurando Taints e Tolerations

Passo 1. Crie um Pod chamado "frontend" que será tolerante a um Taint específico. Exemplo de arquivo de manifesto para o Pod "frontend" chamado `frontend-pod.yaml`:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: frontend
spec:
  containers:
  - name: frontend-container
    image: nginx
    ports:
    - containerPort: 80
  tolerations:
  - key: "example.com/my-taint"
    operator: "Exists"
    effect: "NoSchedule"
```

</p>
</details>

Passo 2. Crie um Taint em um dos nós do seu cluster. Vamos usar o nó chamado "node-1" como exemplo. Execute o seguinte comando para adicionar o Taint ao nó:

<details><summary>show</summary>
<p>

```bash
kubectl taint nodes node-1 example.com/my-taint=NoSchedule:NoSchedule
```

</p>
</details>

Passo 4. Aplique o arquivo de manifesto do Pod "frontend" no cluster:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f frontend-pod.yaml
```

</p>
</details>

Passo 5. Verifique se o Pod foi criado e está em execução:

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Você verá o Pod "frontend" em execução no cluster, mesmo com o Taint aplicado ao nó.

## Atividade 2: Configurando Taints e Tolerations com valores específicos

Passo 1. Crie um novo Pod chamado "backend" que será tolerante a um Taint específico com um valor específico. Exemplo de arquivo de manifesto para o Pod "backend" chamado `backend-pod.yaml`:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: backend
spec:
  containers:
  - name: backend-container
    image: mysql
    env:
    - name: DB_HOST
      value: backend-db
  tolerations:
  - key: "example.com/my-taint"
    operator: "Equal"
    value: "backend-node"
    effect: "NoSchedule"
```

</p>
</details>

Passo 2. Crie um Taint no nó "node-2" com uma chave e valor específicos. Execute o seguinte comando para adicionar o Taint ao nó:

<details><summary>show</summary>
<p>

```bash
kubectl taint nodes node-2 example.com/my-taint=backend-node:NoSchedule
```

</p>
</details>

Passo 3. Aplique o arquivo de manifesto do Pod "backend" no cluster:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f backend-pod.yaml
```

</p>
</details>

Passo 4. Verifique se o Pod foi criado e está em execução:

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Você verá o Pod "backend" em execução no cluster, tolerante ao Taint com o valor "backend-node" aplicado ao nó "node-2".

> :memo: **Note:** Essas são apenas algumas atividades práticas básicas para trabalhar com Taints and Tolerations no Kubernetes. Você pode explorar mais recursos e experimentar diferentes configurações para aprofundar seu conhecimento.