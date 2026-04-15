module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "shailesh-final-cluster"
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # ✅ क्लस्टर अ‍ॅक्सेस सेटिंग्ज (इथेच हव्या होत्या त्या ओळी)
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t3.small"]
    }
  }

  # मागील रनमधील कॉन्फ्लिक्ट टाळण्यासाठी हा भाग कमेंट आऊट ठेवला आहे
  /*
  access_entries = {
    github_runner = {
      principal_arn = "arn:aws:iam::588319086414:user/terraform-aws"
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = { type = "cluster" }
        }
      }
    }
  }
  */
}