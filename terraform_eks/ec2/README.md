# cluster EKS com Terraform

## A Estrutura do projeto

```
.
├── curso
│   ├── main.tf
├── infra
│   ├── eks.tf
│   ├── Provider.tf
│   ├── securityGroup.tf
│   ├── Variables.tf
│   └── vpc.tf
└── README.md
```

O nome do cluster está declarado na diretiva `cluster_name` no arquivo _curso/main.tf_.

O tipo (flavor) da instancia está declarado no arquivo infra/eks.tf na diretiva `instance_types`.

```Bash
$ cd curso
$ terraform init
```

```Bash
$ terraform plan
```

```Bash
$ terraform apply
```
