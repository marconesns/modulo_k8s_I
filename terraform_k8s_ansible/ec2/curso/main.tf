module "prod" {
  source     = "../infra"
  instancia  = "t3.medium"
  regiao_aws = "us-west-2"
  chave      = "ck-prod"
  image      = "ami-03f65b8614a860c29"
}

output "ec2_master_map_instance" {
  value = module.prod.ec2_master_map
}

output "ec2_worker_map_instance" {
  value = module.prod.ec2_worker_map
}
