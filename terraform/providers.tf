provider "aws" {
  region = "us-west-1"
}

# हे नवीन ॲड कर - यामुळे localhost चा एरर जाईल
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}