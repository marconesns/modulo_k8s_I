# Exercícios Resource Requests e Limits

## Atividade 1: Definindo resource requests e limits em um Pod

Objetivo: Definir resource requests e limits para um Pod.

Passo: 1. Crie um arquivo YAML chamado `pod.yaml` e adicione o seguinte conteúdo:

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
      resources:
        requests:
          cpu: "100m"
          memory: "256Mi"
        limits:
          cpu: "200m"
          memory: "512Mi"
```

</p>
</details>

Passo: 2. Aplique o arquivo YAML para criar o Pod:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f pod.yaml
```

</p>
</details>

Passo: 3. Verifique se o Pod foi criado corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl get pods
```

</p>
</details>

Você deve ver o Pod `my-pod` na lista, indicando que foi criado com sucesso.

## Atividade 2: Configurando Quota

Objetivo: Criar uma quota para limitar os recursos consumidos por um namespace.

Passo: 1. Crie um arquivo YAML chamado `quota.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-quota
spec:
  hard:
    requests.cpu: "1"
    requests.memory: 1Gi
    limits.cpu: "2"
    limits.memory: 2Gi
```

</p>
</details>

Passo: 2. Aplique o arquivo YAML para criar a quota:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f quota.yaml
```

</p>
</details>

Passo: 3. Verifique se a quota foi criada corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl get resourcequota
```

</p>
</details>

Você deve ver a quota `my-quota` na lista, indicando que foi criada com sucesso.

## Atividade 3: Definindo LimitRange

Objetivo: Configurar um LimitRange para definir limites de recursos padrão para os Pods em um namespace.

Passo: 1. Crie um arquivo YAML chamado `limitrange.yaml` e adicione o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: my-limitrange
spec:
  limits:
    - default:
        cpu: "200m"
        memory: "512Mi"
      defaultRequest:
        cpu: "100m"
        memory: "256Mi"
      type: Container
```

</p>
</details>

Passo: 2. Aplique o arquivo YAML para criar o LimitRange:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f limitrange.yaml
```

</p>
</details>

Passo: 3. Verifique se o LimitRange foi criado corretamente:

<details><summary>show</summary>
<p>

```bash
kubectl get limitrange
```

```bash
kubectl describe limitrange my-limit
```

</p>
</details>

Você deve ver o LimitRange `my-limitrange` na lista, indicando que foi criado com sucesso.

> :memo: **Nota:** Esses exercícios práticos devem ajudá-lo a começar a trabalhar com resource requests e limits, quota e limitrange no Kubernetes. Lembre-se de adaptar os valores e configurações de acordo com suas necessidades específicas.