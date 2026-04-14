module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = "shailesh-s3-cluster"
  cluster_version = "1.31"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # v19 मध्ये GitHub Actions ला अ‍ॅक्सेस देण्यासाठी हा ब्लॉक हवाच
  manage_aws_auth_configmap = true

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["t3.small"]
    }
  }

  # GitHub Runner ज्या IAM युजरने काम करतोय, त्याला इथे अ‍ॅड करा
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::588319086414:user/terraform-aws"
      username = "terraform-aws"
      groups   = ["system:masters"]
    }
  ]
}