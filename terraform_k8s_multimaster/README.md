# Instancias EC2

Para subir as instancias é necessário criar o par de chave rsa com ssh-keygen conforme demonstrando abaixo. O nome utilizado neste exemplo é ck-prod para a chave privada e ck-prod.pub para chave publica. Caso deseje alterar será necessário editar o arquivo das variaveis `ec2/curso/main.tf` o Terraform. Procures por `chave` e altere o valor.

Criando a chave

```
$ ssh-keygen -f ec2/curso/ck-prod -t rsa -N ""
```

### Criando as instancias

Para criar as instancias é necessário carregar os módulos do Terraform executando o comando com `init` confirmo demonstrado abaixo. Este procedimento deverá ser executado dentro do diretório `ec2/curso`

```
$ terraform init
```

Apos este procedimento deverá excecutar um `plan` e identificar se existe alguma pendencia.

```
$ terraform plan
```

Pronto agora é possivel criar as instancia executando um `apply` e respondendo _yes_ para proseguir.

```
$ terraform apply
```

Este procedimento criará varias instancias ec2 sendo `haproxy`, `master` e `workers` de acordo como valor definido no campo _count_ do arquivo `infra/main.tf`. Ao final tem uma instrução `output` que mostrará os IPs públicos dados a cada instancia. Esses endereços serão usados para alterar o inventário do Ansible.

Pàra visualizar o output novamente, basta digitar o comando a seguir.

```
$ terraform output
```
