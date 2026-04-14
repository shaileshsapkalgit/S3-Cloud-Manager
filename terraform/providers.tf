module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "shailesh-vpc"
  cidr = "10.0.0.0/16"

  # ✅ हे झोन्स us-east-1 साठी बरोबर आहेत
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
}

# --- Providers Section ---

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # ❌ इथे eu-central-1 होता, तो आता us-east-1 करा
  region = "us-east-1"
}