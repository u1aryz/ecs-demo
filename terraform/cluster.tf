#####################################
# ECS Cluster Settings
#####################################
resource "aws_ecs_cluster" "cluster" {
  name = "${var.app_name}-cluster"
}
