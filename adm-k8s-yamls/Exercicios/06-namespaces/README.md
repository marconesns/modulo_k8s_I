# Exercícios Namespaces

## Atividade 1: Criação de Namespace

Passo 1. Crie um novo namespace chamado "my-namespace":

<details><summary>show</summary>
<p>

```bash
kubectl create namespace my-namespace
```

</p>
</details>

Passo 2. Verifique se o namespace foi criado corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl get namespaces
```

</p>
</details>

## Atividade 2: Resource Quota

Passo 1. Crie um novo namespace chamado "quota-namespace":

<details><summary>show</summary>
<p>

```bash
kubectl create namespace quota-namespace
```

</p>
</details>

Passo 2. Crie uma Resource Quota chamada "my-quota" nesse namespace, com as seguintes restrições:

   - Limite de CPU: 1 unidade.
   - Limite de memória: 512MB.
   - Limite de objetos: 10.

<details><summary>show</summary>
<p>

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-quota
  namespace: quota-namespace
spec:
  hard:
    cpu: "1"
    memory: 512Mi
    pods: "10"
EOF
```

</p>
</details>

Passo 3. Verifique se a Resource Quota foi criada corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl describe resourcequota my-quota -n quota-namespace
```

</p>
</details>

Passo 4. Crie alguns pods, deployments ou services dentro do namespace "quota-namespace" para testar as restrições impostas pela Resource Quota.

## Atividade 3: Edição de Resource Quota

Passo 1. Aumente o limite de CPU da Resource Quota "my-quota" para 2 unidades:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-quota
  namespace: quota-namespace
spec:
  hard:
    cpu: "2"
    memory: 512Mi
    pods: "10"
EOF
```

</p>
</details>

Passo 2. Verifique se a alteração foi aplicada corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl describe resourcequota my-quota -n quota-namespace
```

</p>
</details>

Passo 3. Crie um novo pod dentro do namespace "quota-namespace" que exceda o novo limite de CPU para verificar se a Resource Quota está funcionando adequadamente.

## Atividade 4: Remoção de Namespace e Resource Quota

Passo 1. Remova o namespace "my-namespace" e verifique se ele foi excluído com sucesso:

<details><summary>show</summary>
<p>

```bash
kubectl delete namespace my-namespace
kubectl get namespaces
```

</p>
</details>

Passo 2. Remova o namespace "quota-namespace" e a Resource Quota associada a ele:

<details><summary>show</summary>
<p>

```bash
kubectl delete namespace quota-namespace
kubectl get namespaces
kubectl get resourcequota -n quota-namespace
```

</p>
</details>

> :memo: **Nota:** Os exemplos acima demonstram como realizar as operações usando a linha de comando do Kubernetes.
