resource "aws_ecr_repository" "app_repo" {
  name                 = "shailesh-new-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true # इमेज पुश केल्यावर सिक्युरिटी स्कॅनिंग होईल
  }

  tags = {
    Project = "S3-Cloud-Manager"
  }
}

# आउटपुटमध्ये URL मिळवण्यासाठी (जी आपल्याला GitHub Actions मध्ये लागेल)
output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}