module "prod" {
  source     = "../infra"
#   instancia  = var.ami_type
#   regiao_aws = var.regiao_aws
#   chave      = var.chave
#   image      = var.aws_ami_id
}


# output "ec2_bastion_map_instance" {
#   value = module.prod.ec2_bastion_map
# }
output "ec2_master_map_instance" {
  value = module.prod.ec2_master_map
}

output "ec2_worker_map_instance" {
  value = module.prod.ec2_worker_map
}
