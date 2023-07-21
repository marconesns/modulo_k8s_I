# Exercícios Armazenamento

Exemplos práticos para que você possa aplicar os conceitos de Persistent Volumes (PVs), Persistent Volume Claims (PVCs) e Storage Classes no Kubernetes:

## Atividade 1: Configurando um Persistent Volume

Passo 1. Crie um arquivo YAML chamado `pv.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  storageClassName: standard
  hostPath:
    path: /data/pv
```

</p>
</details>

Passo 2. Aplique a configuração do Persistent Volume usando o comando:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f pv.yaml
```

</p>
</details>

.Atividade 2: Criando um Persistent Volume Claim

Passo 1. Crie um arquivo YAML chamado `pvc.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
  storageClassName: standard
```

</p>
</details>

Passo 2. Aplique a configuração do Persistent Volume Claim usando o comando:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f pvc.yaml
```

</p>
</details>

.Atividade 3: Definindo uma Storage Class

Passo 1. Crie um arquivo YAML chamado `sc.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp2
```

</p>
</details>

Passo 2. Aplique a configuração da Storage Class usando o comando:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f sc.yaml
```

</p>
</details>

.Atividade 4: Criando um Deployment com Persistent Volume Claim

Passo 1. Crie um arquivo YAML chamado `deployment.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
        - name: my-app
          image: my-app:latest
          volumeMounts:
            - name: data-volume
              mountPath: /app/data
      volumes:
        - name: data-volume
          persistentVolumeClaim:
            claimName: my-pvc
```

</p>
</details>

Passo 2. Aplique a configuração do Deployment usando o comando:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f deployment.yaml
```

</p>
</details>

> :memo: **Note:** Esses exemplos práticos permitirão que você crie um ambiente funcional no Kubernetes, utilizando Persistent Volumes, Persistent Volume Claims e Storage Classes para armazenar e compartilhar dados entre os pods do seu cluster. Lembre-se de adaptar os nomes e configurações de acordo com suas necessidades e recursos disponíveis na sua infraestrutura.
