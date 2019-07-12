#####################################
# IAM Role Settings
#####################################
data "aws_iam_policy_document" "task-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-task-role" {
  name               = "ecs-task-role"
  path               = "/system/"
  assume_role_policy = "${data.aws_iam_policy_document.task-assume-role-policy.json}"
}

resource "aws_iam_policy_attachment" "ecs-task-role-attach" {
  name       = "ecs-task-role-attach"
  roles      = ["${aws_iam_role.ecs-task-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "autoscaling-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-autoscale-role" {
  name               = "ecs-autoscale-role"
  path               = "/system/"
  assume_role_policy = "${data.aws_iam_policy_document.autoscaling-assume-role-policy.json}"
}

resource "aws_iam_policy_attachment" "ecs-autoscale-role-attach" {
  name       = "ecs-autoscale-role-attach"
  roles      = ["${aws_iam_role.ecs-autoscale-role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
