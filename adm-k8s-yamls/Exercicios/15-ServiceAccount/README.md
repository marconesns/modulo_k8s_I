# Exercícios Service Account

## Atividade 1: Criando uma conta de serviço com acesso administrativo a um namespace específico

Passo 1: Crie um arquivo YAML chamado "serviceaccount.yaml" com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```bash
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-account
  namespace: homologacao
```

</p>
</details>

Passo 2: Aplique o arquivo YAML usando o comando kubectl:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f serviceaccount.yaml
```

</p>
</details>

# Atividade 2: Criando uma Secret com um token personalizado para a conta de serviço

Passo 1: Crie um arquivo YAML chamado "secret.yaml" com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: admin-token
  namespace: homologacao
type: kubernetes.io/service-account-token
```

</p>
</details>

Passo 2: Aplique o arquivo YAML usando o comando kubectl:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f secret.yaml
```

</p>
</details>

# Atividade 3: Obtendo o token da Secret da conta de serviço

Passo 1: Execute o seguinte comando para obter o token da Secret:

<details><summary>show</summary>
<p>

```bash
kubectl get secret admin-token -n homologacao -o jsonpath='{.data.token}' | base64 --decode
```

</p>
</details>

Após executar o comando, você obterá o token associado à Secret criada. Esse token pode ser usado para autenticação em outros recursos do Kubernetes, como APIs ou no contexto de um cliente Kubernetes.

> :memo: **Note:** Certifique-se de que o nome da conta de serviço e da Secret estejam corretos nos arquivos YAML e comandos utilizados.