#####################################
# ECS Task Settings
#####################################
data "template_file" "task" {
  template = "${file("task-definitions/container_definitions.json")}"
  vars = {
    proxy_repo = "${var.proxy_repo}"
    api_repo   = "${var.api_repo}"
  }
}

resource "aws_ecs_task_definition" "task" {
  family                   = "api"
  container_definitions    = "${data.template_file.task.rendered}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = "${aws_iam_role.ecs-task-role.arn}"
  cpu                      = 256
  memory                   = 512
}
