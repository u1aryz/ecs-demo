#####################################
# ECS Service Auto Scale Settings
#####################################
resource "aws_appautoscaling_target" "ecs-service-target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = "${aws_iam_role.ecs-autoscale-role.arn}"
  min_capacity       = 1
  max_capacity       = 2
}

resource "aws_appautoscaling_policy" "scale-out" {
  name               = "scale-out"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "${aws_appautoscaling_target.ecs-service-target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.ecs-service-target.service_namespace}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = ["aws_appautoscaling_target.ecs-service-target"]
}

resource "aws_appautoscaling_policy" "scale-in" {
  name               = "scale-in"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "${aws_appautoscaling_target.ecs-service-target.scalable_dimension}"
  service_namespace  = "${aws_appautoscaling_target.ecs-service-target.service_namespace}"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = ["aws_appautoscaling_target.ecs-service-target"]
}

resource "aws_cloudwatch_metric_alarm" "service-scale-out-alarm" {
  alarm_name          = "${var.app_name}-ECSService-CPU-Utilization-High-75"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "75"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.cluster.name}"
    ServiceName = "${aws_ecs_service.service.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.scale-out.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "service-scale-in-alarm" {
  alarm_name          = "${var.app_name}-ECSService-CPU-Utilization-Low-25"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "300"
  statistic           = "Average"
  threshold           = "25"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.cluster.name}"
    ServiceName = "${aws_ecs_service.service.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.scale-in.arn}"]
}
