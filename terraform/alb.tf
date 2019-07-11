#####################################
# ALB Settings
#####################################
resource "aws_alb" "alb" {
  name                       = "${var.app_name}-alb"
  security_groups            = ["${aws_security_group.public-web.id}"]
  subnets                    = ["${aws_subnet.public-subnet1.id}", "${aws_subnet.public-subnet2.id}"]
  internal                   = false
  enable_deletion_protection = false
  tags = {
    Name  = "${var.app_name}-alb"
    Group = "${var.app_name}"
  }
}

resource "aws_alb_target_group" "alb" {
  name        = "${var.app_name}-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.vpc.id}"
  target_type = "ip"
  tags = {
    Name  = "${var.app_name}-target-group"
    Group = "${var.app_name}"
  }
}

resource "aws_alb_listener" "alb" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = "${aws_alb_target_group.alb.id}"
    type             = "forward"
  }
}
