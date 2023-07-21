module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = var.cluster_name
  cluster_version = "1.26"

  # cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_group_defaults = {
    desired_size = 50
  }

  eks_managed_node_groups = {
    scttic = {
      min_size               = 1
      max_size               = 5
      desired_size           = 2
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id]
      instance_types         = ["t3.small"]
    }
  }
}