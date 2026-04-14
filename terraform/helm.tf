provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

resource "helm_release" "bank_app" {
  name       = "shailesh-bank-app"
  chart      = "./shailesh-bank-chart" # इथे तुझ्या हेल्म चार्ट फोल्डरचा पाथ दे

  set {
    name  = "service.port"
    value = "8080"
  }

  set {
    name  = "service.targetPort"
    value = "8080"
  }

  depends_on = [module.eks]
}