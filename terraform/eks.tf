module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = "shailesh-s3-cluster"
  cluster_version = "1.31"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  cluster_endpoint_public_access = true

  # सध्या हे false करा जेणेकरून localhost चा एरर येणार नाही
  manage_aws_auth_configmap = false

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_types = ["t3.small"]
    }
  }
}