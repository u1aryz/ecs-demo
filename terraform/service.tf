#####################################
# ECS Service Settings
#####################################
resource "aws_ecs_service" "service" {
  name            = "${var.app_name}-service"
  cluster         = "${aws_ecs_cluster.cluster.id}"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"
  load_balancer {
    target_group_arn = "${aws_alb_target_group.alb.id}"
    container_name   = "proxy"
    container_port   = 80
  }
  network_configuration {
    subnets = [
      "${aws_subnet.public-subnet1.id}",
      "${aws_subnet.public-subnet2.id}"
    ]
    security_groups = [
      "${aws_security_group.internal-web.id}"
    ]
    assign_public_ip = "true"
  }
  depends_on = [
    "aws_alb_listener.alb"
  ]
}
