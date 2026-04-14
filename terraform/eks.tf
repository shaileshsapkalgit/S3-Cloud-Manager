module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = "shailesh-s3-cluster"
  cluster_version = "1.31"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # अ‍ॅक्सेसचा अडथळा दूर करण्यासाठी हे २ ब्लॉक्स हवेतच
  manage_aws_auth_configmap = true

  # हे नवीन ॲड कर - यामुळे Runner ला क्लस्टर शोधणं सोपं जाईल
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["t3.small"]
    }
  }

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::588319086414:user/terraform-aws"
      username = "terraform-aws"
      groups   = ["system:masters"]
    }
  ]
}