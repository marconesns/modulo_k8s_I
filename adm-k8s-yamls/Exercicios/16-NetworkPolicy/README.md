# Exercícios Network Policy

Nesta atividade, você irá implementar uma Network Policy no Kubernetes para uma aplicação de 3 camadas, composta por um frontend, um backend e um banco de dados. O objetivo é garantir que as conexões permitidas sejam restritas de acordo com as regras de segurança estabelecidas. As regras são as seguintes:

. O frontend tem regras de entrada e saída permitidas.
. O container backend só recebe conexões de entrada e saída do frontend.
. O banco de dados só recebe conexões de entrada e saída do backend.

## Atividade 1: Network Policy para o Frontend

Passo 1. Crie um arquivo YAML chamado `frontend-policy.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend-policy
spec:
  podSelector:
    matchLabels:
      app: frontend
  ingress:
  - {}
  egress:
  - {}
```

</p>
</details>

Passo 2. Aplique a Network Policy ao cluster Kubernetes usando o comando `kubectl`:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f frontend-policy.yaml
```

</p>
</details>

Isso criará a Network Policy `frontend-policy` que permitirá todas as conexões de entrada e saída para o frontend.

## Atividade 2: Network Policy para o Backend

Passo 1. Crie um arquivo YAML chamado `backend-policy.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-policy
spec:
  podSelector:
    matchLabels:
      app: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: frontend
```

</p>
</details>

Passo 2. Aplique a Network Policy ao cluster Kubernetes usando o comando `kubectl`:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f backend-policy.yaml
```

</p>
</details>

Isso criará a Network Policy `backend-policy` que permitirá apenas as conexões de entrada e saída do backend para o frontend.

## Atividade 3: Network Policy para o Banco de Dados

Passo 1. Crie um arquivo YAML chamado `database-policy.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: database-policy
spec:
  podSelector:
    matchLabels:
      app: database
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: backend
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: backend
```

</p>
</details>

Passo 2. Aplique a Network Policy ao cluster Kubernetes usando o comando `kubectl`:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f database-policy.yaml
```

</p>
</details>

Isso criará a Network Policy `database-policy` que permitirá apenas as conexões de entrada e saída do banco de dados para o backend.

> :memo: **Note:** Com essas três Network Policies aplicadas, você terá uma configuração de rede segura para a sua aplicação de 3 camadas no Kubernetes. Lembre-se de criar os deployments e services correspondentes para o frontend, backend e banco de dados, e adicionar os labels corretos nos pods para que as Network Policies sejam aplicadas corretamente.