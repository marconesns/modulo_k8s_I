# Exercícios Alocação avançada de pods

## Atividade 1: Implantação de DaemonSet

Passo 1. Crie um arquivo YAML chamado `daemonset.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-daemonset
spec:
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        ports:
        - containerPort: 80
```

</p>
</details>

Passo 2. Execute o seguinte comando para criar o DaemonSet:

<details><summary>show</summary>
<p>

```bash
kubectl create -f daemonset.yaml
```

</p>
</details>

Passo 3. Verifique se o DaemonSet foi criado corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl get daemonsets
kubectl describe daemonset nginx-daemonset
```

</p>
</details>

Passo 4. Verifique se os Pods do DaemonSet estão em execução:

<details><summary>show</summary>
<p>

```bash
kubectl get pods -l app=nginx
```

</p>
</details>

## Atividade 2: Atualização de DaemonSet

Passo 1. Atualize o arquivo YAML `daemonset.yaml` para usar uma imagem diferente, por exemplo, `nginx:1.24.0`.

Passo 2. Execute o seguinte comando para atualizar o DaemonSet:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f daemonset.yaml
```

</p>
</details>

Passo 3. Verifique se a atualização está em andamento:

<details><summary>show</summary>
<p>

```bash
kubectl get daemonsets
kubectl describe daemonset nginx-daemonset
```

</p>
</details>

Passo 4. Verifique se os Pods estão usando a nova versão da imagem:

<details><summary>show</summary>
<p>

```bash
kubectl get pods -l app=nginx
```

</p>
</details>

## Atividade 3: Implantação de Pods estáticos

Passo 1. Acesse um dos nodes workers.

<details><summary>show</summary>
<p>

```bash
kubectl debug node/curso-worker -it --image=busybox
chroot /host
```

</p>
</details>

Passo 2. Crie um arquivo YAML chamado `pod.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```bash
cat >> pod.yaml<<EOF
apiVersion: v1
kind: Pod
metadata:
  name: static-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
    ports:
    - containerPort: 80
EOF
```

</p>
</details>

Passo 3. Agora mova o arquivo pod.yaml para o diretório /etc/kubernetes/manifests/ em qualquer node.

<details><summary>show</summary>
<p>

```bash
mv pod.yaml /etc/kubernetes/manifests/
```

</p>
</details>

Passo 4. Verifique o status do Pod e os logs para garantir que ele esteja em execução:

<details><summary>show</summary>
<p>

```bash
kubectl get pods static-pod
kubectl logs static-pod
```

```bash
crictl ps
crictl get pods
crictl delete pod static-pod
crictl get pods
crictl stop 129fd7d382018 # Mude para o Id do container
sleep 20
crictl ps
```

</p>
</details>

Passo 5. Remova o Static Pod:

<details><summary>show</summary>
<p>

```bash
rm /etc/kubernetes/manifests/pod.yaml
```

</p>
</details>

Passo 6. Remova o Pod Debug:

<details><summary>show</summary>
<p>

```bash
kubectl get pods
kubectl delete pod node-debugger-curso-worker-xxxxx
```

</p>
</details>

> :memo: **Note:** Essas atividades práticas permitem que você experimente e se familiarize com o uso de DaemonSets e Pods estáticos no Kubernetes. Lembre-se de adaptar os exemplos às suas necessidades específicas e explorar mais recursos e configurações do Kubernetes.