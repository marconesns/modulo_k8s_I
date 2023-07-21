# Exercícios Roles e RoleBinding

Está um exemplo de atividade de Kubernetes usando o conceito de RBAC (Role-Based Access Control) com recursos Roles e RoleBindings para uma conta de usuário que terá acesso a Pods, Deployments e Services, permitindo a criação, listagem, acompanhamento (watch) e atualização:

> :bulb: **Tip:** Para este exercicio utilize o usuário criado no capitulo anterior. Certifique-se de ter criado.

## Atividade 1: Crie um arquivo chamado `user-rbac.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: homologacao
---

apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: homologacao
  name: user-role
rules:
- apiGroups: [""]
  resources: ["pods", "deployments", "services"]
  verbs: ["create", "list", "watch", "update"]
---

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  namespace: homologacao
  name: user-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: user-role
subjects:
- kind: User
  name: <username>  # Substitua <username> pelo nome de usuário do usuário real
```

</p>
</details>

## Atividade 2: Substitua `<username>` pelo nome de usuário real do usuário para o qual você deseja conceder acesso.

## Atividade 3: Execute o seguinte comando para criar o namespace, a role e o role binding no Kubernetes:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f user-rbac.yaml
```

</p>
</details>

Isso criará um novo namespace chamado `homologacao` e definirá uma Role chamada `user-role` que permite ao usuário especificado criar, listar, acompanhar (watch) e atualizar recursos de Pods, Deployments e Services. Além disso, um RoleBinding chamado `user-role-binding` será criado para associar a Role ao usuário especificado.

Certifique-se de que você tem as permissões necessárias para executar esse comando no cluster Kubernetes.

> :memo: **Note:** Após a execução dessas etapas, o usuário especificado terá acesso aos recursos especificados de acordo com as permissões definidas na Role.


******


# Execícios ClusterRoles

Exemplo de atividade de Kubernetes usando o conceito de RBAC (Role-Based Access Control) com recursos ClusterRoles e ClusterRoleBindings para conceder acesso a um usuário para criar, listar, assistir (watch) e atualizar recursos em todo o cluster:

> :warning: **Warning:** Para este exercicio utilize o usuário criado no capitulo anterior. Certifique-se de ter criado.

## Atividade 1: Crie um arquivo chamado `user-cluster-rbac.yaml` com o seguinte conteúdo:

<details><summary>show</summary>
<p>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: user-cluster-role
rules:
- apiGroups: [""]
  resources: ["pods", "deployments", "services"]
  verbs: ["create", "list", "watch", "update"]

---

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: user-cluster-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: user-cluster-role
subjects:
- kind: User
  name: <username>  # Substitua <username> pelo nome de usuário do usuário real
```

</p>
</details>

.Atividade 2: Substitua `<username>` pelo nome de usuário real do usuário para o qual você deseja conceder acesso.

.Atividade 3: Execute o seguinte comando para criar a ClusterRole e o ClusterRoleBinding no Kubernetes:

<details><summary>show</summary>
<p>

```bash
kubectl apply -f user-cluster-rbac.yaml
```

</p>
</details>

Isso criará uma ClusterRole chamada `user-cluster-role` que permite ao usuário especificado criar, listar, assistir (watch) e atualizar recursos de Pods, Deployments e Services em todo o cluster. Além disso, um ClusterRoleBinding chamado `user-cluster-role-binding` será criado para associar a ClusterRole ao usuário especificado.

Certifique-se de que você tem as permissões necessárias para executar esse comando no cluster Kubernetes.

> :memo: **Note:** Após a execução dessas etapas, o usuário especificado terá acesso aos recursos especificados em todo o cluster de acordo com as permissões definidas na ClusterRole.