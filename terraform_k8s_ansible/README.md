# Instancias EC2

Para subir as instancias é necessário criar o par de chave rsa com ssh-keygen conforme desmotrando abaixo. O nome utilizado neste exemplo é ck-prod para a chave privada e ck-prod.pub para chave publica. Caso deseje alterar será necessario editar o arquivo das variavies `ec2/curso/main.tf` o Terraform. Procures por `chave` e altere o valor.

Criando a chave

```
$ ssh-keygen -f ec2/curso/ck-prod -t rsa -N ""
```

### Criando as instancias

Para criar as instancias é necessário carregar os modulos do Terraform executando o comando com `init` confirme demonstrado abaixo. Este procedimento deverá ser executado dentro do diretório `ec2/curso`

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

Este procedimento criará tres instancias ec2 sendo uma `master` e duas `workers`. Ao final tem uma instrução `output` que mostrará os IPs públicos dados a cada instancia. Esses endereços serão usados para alterar o inventário do Ansible.

Pàra visualizar o output novamente, basta digitar o comando a seguir.

```
$ terraform output
```

# Criando Cluster k8s

Este procedimento será realizado dentro do subdiretório `cluster`. Volte a raiz do projecto e acesse o diretório cluster e faça a alteração no arquivo `inventory/main.yml` substituido os valores dos IPs abaixo de master -> hosts e também nodes -> hosts. Esses valores foram informado na saída da criação das instancias.

Caso você tenha alterado o nome da chave rsa, será necessario também alterar no arquivo de `ansible.cfg` na diretiva `private_key_file=../ec2/curso/ck-prod`.

Apos alteração faça um teste de conexão com o comando a seguir.

```
$ ansible all -m ping -u ubuntu
```

Se a saída do comando anterior for executada com sucesso, e só neste caso podemos então executar o playbook ansible para criar o nosso cluster.

### Executando playbook

```
$ ansible-playbook kubernetes-with-crio-playbook.yml
```

Agora é só sucesso... ;-)
