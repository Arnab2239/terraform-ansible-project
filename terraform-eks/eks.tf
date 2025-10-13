module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name                   = local.name
  kubernetes_version     = "1.31"
  endpoint_public_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets

  eks_managed_node_groups = {
    bankapp-ng = {
      desired_size  = 2    # <-- এখানে desired_capacity এর বদলে desired_size
      min_size      = 1
      max_size      = 3
      capacity_type = "ON_DEMAND"
      instance_types   = ["t2.medium"]
      attach_cluster_primary_security_group = true
    }
  }


  addons = {
    coredns   = { most_recent = true }
    kube-proxy = { most_recent = true }
    vpc-cni   = { most_recent = true }
  }

  

  tags = local.tags
}

