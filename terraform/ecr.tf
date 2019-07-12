#####################################
# ECR Settings
#####################################
resource "aws_ecr_repository" "proxy-repo" {
  name = "proxy-repo"
}

resource "aws_ecr_repository" "api-repo" {
  name = "api-repo"
}
