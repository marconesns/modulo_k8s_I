## Exercício Integridade das Aplicações

Este Exercício envolve práticas da configuração de readiness probes e liveness probes no Kubernetes, e execução de container de inicialização.

Atividade 1: Crie um Deployment chamado "webapp" com uma réplica, usando a imagem "nginx:1.24.0". Configure uma probe de readiness para verificar o caminho "/" na porta 80. Certifique-se de que o aplicativo esteja pronto para receber tráfego somente quando responder com sucesso à sonda de readiness.

Passo 1: Criação do Deployment "webapp" com uma réplica

<details><summary>show</summary>
<p>

```bash
kubectl create deployment webapp --image=nginx:1.24.0 --replicas=1
```

</p>
</details>

Passo 2: Configuração de uma probe de readiness para o caminho "/" na porta 80. Utilize o subcomando edit do kubectl.

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
        - name: webapp
          image: nginx:1.24.0
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
```

</p>
</details>

Atividade 2: Crie um Pod chamado "database" usando a imagem "postgres:latest". Configure uma probe de liveness para verificar a porta 5432 a cada 10 segundos. Reinicie o contêiner se a sonda de liveness falhar três vezes consecutivas.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: database
spec:
  containers:
    - name: database
      image: postgres:latest
      ports:
        - containerPort: 5432
      livenessProbe:
        tcpSocket:
          port: 5432
        initialDelaySeconds: 10
        periodSeconds: 10
        failureThreshold: 3
      env:
      - name: POSTGRES_PASSWORD
        value: S3gr3d0
```

</p>
</details>

Atividade 3: Crie um Deployment chamado "frontend" com duas réplicas, usando a imagem "nginx:1.24.0". Configure uma probe de readiness para verificar a porta 80 a cada 5 segundos. Certifique-se de que pelo menos uma réplica esteja pronta para receber tráfego.

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 2
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
        - name: frontend
          image: nginx:1.24.0
          ports:
            - containerPort: 80
          readinessProbe:
            tcpSocket:
              port: 80
            periodSeconds: 5
            successThreshold: 1
```

</p>
</details>


Atividade 4: Crie um Pod chamado "migration" que execute um initContainer antes de iniciar o contêiner principal. O initContainer deve usar a imagem "busybox" e executar um comando sleep 20. O contêiner principal deve usar a imagem "nginx" e iniciar depois que o initContainer concluir com sucesso.

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: migration
spec:
  containers:
    - name: migration-init
      image: busybox
      command: ["/bin/sh", "-c"]
      args: ["sleep 20"]
      volumeMounts:
        - name: data-volume
          mountPath: /data
    - name: main-container
      image: nginx
      volumeMounts:
        - name: data-volume
          mountPath: /data
  initContainers:
    - name: init-migration
      image: busybox
      command: ["/bin/sh", "-c"]
      args: ["sleep 20"]
      volumeMounts:
        - name: data-volume
          mountPath: /data
  volumes:
    - name: data-volume
      emptyDir: {}
```

</p>
</details>

Neste exemplo, o Pod "migration" possui três contêineres: "migration-init" (initContainer), "main-container" e "init-migration" (initContainer). O initContainer "init-migration" executa o sleep 20 antes que o contêiner principal "main-container" seja iniciado. Ambos os contêineres compartilham um volume vazio para acessar dados.

<details><summary>show</summary>
<p>

```bash
watch kubectl get pods
```

</p>
</details>

.A saída é algo como:
```
NAME        READY   STATUS     RESTARTS   AGE
migration   0/2     Init:0/1   0          8s
```

Acompanhe e veja que o migration-init será reiniciado sempre que o sleep zera a contagem, um novo container sobe no pod.

.A saída é algo como:
```
NAME        READY   STATUS     RESTARTS   AGE
migration   1/2     NotReady   0          48s
```

Você pode aplicar o arquivo YAML usando o comando `kubectl apply -f <arquivo.yaml>`.

> :memo: **Note:** Lembre-se de aplicar os arquivos YAML usando o comando `kubectl apply -f <arquivo.yaml>`.