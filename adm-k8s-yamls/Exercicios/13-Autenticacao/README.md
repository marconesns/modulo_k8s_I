## Exercícios Autenticação

Nesta atividade, você aprenderá a criar um usuário com um certificado no Kubernetes usando o recurso `CertificateSigningRequest`. Isso envolverá a criação de uma solicitação de assinatura de certificado, aprovação manual da solicitação e obtenção do certificado assinado.

## Atividade 1: Criação da solicitação de assinatura de certificado (CSR)

Passo 1. Crie um arquivo chamado `user-csr.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: username-csr
spec:
  groups:
  - system:authenticated
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - client auth
  request: <BASE64_ENCODED_CSR>
```

</p>
</details>

Certifique-se de substituir `<BASE64_ENCODED_CSR>` pelo valor base64 da solicitação de assinatura de certificado gerada a seguir.

Passo 2. Crie um arquivo chamado `user-csr.conf` com o seguinte conteúdo:

```
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
prompt = no

[req_distinguished_name]
C = BR
ST = Estado
L = Cidade
O = Organization
OU = Kubernetes
CN = username

[v3_req]
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth
```

Passo 3. Execute o seguinte comando para gerar a solicitação de assinatura de certificado (CSR) e codificá-la em base64:

<details><summary>show</summary>
<p>

```bash
openssl req -new -nodes -newkey rsa:2048 -keyout user.key -out user.csr -config user-csr.conf
```

```bash
BASE64_ENCODED_CSR=$(cat user.csr | base64 | tr -d '\n')
```

</p>
</details>

Passo 4. Substitua `<BASE64_ENCODED_CSR>` no arquivo `user-csr.yaml` pelo valor de `BASE64_ENCODED_CSR` que você acabou de obter.

<details><summary>show</summary>
<p>

```bash
echo $BASE64_ENCODED_CSR >> user-csr.yaml
```

</p>
</details>

.Atividade 2: Criação da solicitação de assinatura de certificado no Kubernetes

Passo 1. Execute o seguinte comando para criar a solicitação de assinatura de certificado no Kubernetes:

<details><summary>show</summary>
<p>

```bash
kubectl create -f user-csr.yaml
```

</p>
</details>

Passo 2. Verifique o status da solicitação de assinatura de certificado usando o seguinte comando:

<details><summary>show</summary>
<p>

```bash
kubectl get certificatesigningrequests
```

</p>
</details>

Passo 3. Quando o status da solicitação estiver pendente, aprove-a manualmente executando o seguinte comando:

<details><summary>show</summary>
<p>

```bash
kubectl certificate approve username-csr
```

</p>
</details>

.Atividade 3: Obtenção do certificado assinado

Passo 1. Execute o seguinte comando para obter o certificado assinado:

<details><summary>show</summary>
<p>

```bash
kubectl get certificatesigningrequest username-csr -o jsonpath='{.status.certificate}' | base64 --decode > user.crt
```

</p>
</details>

Passo 2. O certificado do usuário estará disponível no arquivo `user.crt`.

.Atividade 4: Configuração do Kubernetes para uso dos certificados

Passo 1. Crie um arquivo chamado `kubeconfig.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
clusters:
- cluster:
    certificate-authority: ca.crt
    server: https://<KUBERNETES_API_SERVER_ADDRESS>
  name: my-cluster
contexts:
- context:
    cluster: my-cluster
    user: username
  name: my-context
current-context: my-context
kind: Config
preferences: {}
users:
- name: username
  user:
    client-certificate: user.crt
    client-key: user.key
```

</p>
</details>

Certifique-se de substituir `<KUBERNETES_API_SERVER_ADDRESS>` pelo endereço correto do servidor de API do seu cluster Kubernetes que poderá ser encontrado na saída do comando `kubectl cluster-info`.

Passo 2. Execute o seguinte comando para configurar o Kubernetes para usar os certificados:

<details><summary>show</summary>
<p>

```bash
kubectl config --kubeconfig=kubeconfig.yaml use-context my-context
```

</p>
</details>

Agora você tem um usuário com um certificado que expira em 90 dias no Kubernetes.

> :memo: **Note:** Certifique-se de substituir as informações no arquivo `user-csr.conf`, `user-csr.yaml` e `kubeconfig.yaml` com os valores corretos para sua organização, localização e cluster Kubernetes.
