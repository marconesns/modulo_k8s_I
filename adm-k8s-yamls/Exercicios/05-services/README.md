# Exercícios - Serviços

## Atividade 1: Criação de um Service com tipo ClusterIP

Passo 1: Crie um arquivo chamado `myapp-deployment.yaml` com a seguinte definição de Deployment:

<details><summary>show</summary>
<p>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: myapp
          image: nginx:latest
          ports:
            - containerPort: 80
```

</p>
</details>

Passo 2: Aplique o arquivo de configuração do Deployment:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f myapp-deployment.yaml
```

</p>
</details>

Passo 3: Crie um arquivo chamado `myapp-service.yaml` com a seguinte definição de Service com tipo ClusterIP:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
spec:
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: ClusterIP
```

</p>
</details>

Passo 4: Aplique o arquivo de configuração do Service:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f myapp-service.yaml
```

</p>
</details>

## Atividade 2: Criação de um Service com tipo NodePort

Passo 1: Crie um arquivo chamado `myapp-service-nodeport.yaml` com a seguinte definição de Service com tipo NodePort:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myapp-service-nodeport
spec:
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: NodePort
```

</p>
</details>

Passo 2: Aplique o arquivo de configuração do Service:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f myapp-service-nodeport.yaml
```

</p>
</details>

## Atividade 3: Verificação do recurso Service e identificação de endpoints

<details><summary>show</summary>
<p>

Passo 1: Verifique o estado do Service com o seguinte comando:

```bash
kubectl get services
```

</p>
</details>


Você deverá ver uma saída que lista o Service `myapp-service` ou `myapp-service-nodeport`, dependendo da atividade anterior.

Passo 2: Identifique os endpoints associados ao Service usando o seguinte comando:

<details><summary>show</summary>
<p>

```bash
kubectl describe service myapp-service
```

</p>
</details>

A saída incluirá uma seção chamada "Endpoints" que mostrará os IPs e portas dos pods que estão sendo selecionados pelo Service.

## Atividade 4: Geração de erro no acesso ao serviço devido a um erro no seletor

Passo 1: Modifique o arquivo `myapp-service.yaml` ou `myapp-service-nodeport.yaml` (dependendo da atividade anterior) e altere o seletor para um valor inexistente. Por exemplo:

<details><summary>show</summary>
<p>

```yaml
...
selector:
  app: nonexistentapp
...
```

</p>
</details>

Passo 2: Aplique novamente o arquivo de configuração do Service modificado:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f myapp-service.yaml  # ou myapp-service-nodeport.yaml
```

</p>
</details>

Passo 3: Verifique que os endpoints não serão listado no serviço aterado no passo 1.

<details><summary>show</summary>
<p>

```bash
kubectl get endpoints
```

</p>
</details>

> :bulb: **Tip:** Isso ocorre porque não temos nenhum pod com label `app: nonexistentapp`

## Atividade 5: Correção do erro no acesso ao serviço corrigindo o seletor

Passo 1: Modifique novamente o arquivo `myapp-service.yaml` ou `myapp-service-nodeport.yaml` (dependendo da atividade anterior) e corrija o seletor para o valor correto. Por exemplo:

<details><summary>show</summary>
<p>

```yaml
...
selector:
  app: myapp
...
```

</p>
</details>

Passo 2: Aplique novamente o arquivo de configuração do Service modificado:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f myapp-service.yaml  # ou myapp-service-nodeport.yaml
```

</p>
</details>

Passo 3: Verifique que os endpoints agora serão listado no serviço aterado no passo 1.

<details><summary>show</summary>
<p>

```bash
kubectl get endpoints
```

</p>
</details>

> :bulb: **Tip:** Isso ocorre porque agora temos correspondencia com label `app: myapp`

> :memo: **Nota** Essas atividades práticas fornecem uma introdução ao uso do recurso Service no Kubernetes, abrangendo diferentes tipos de serviços, verificação do estado do Service e identificação dos endpoints associados. Além disso, demonstram como erros no seletor podem afetar o acesso ao serviço e como corrigir esses erros. Lembre-se de adaptar os arquivos YAML às configurações do seu ambiente.