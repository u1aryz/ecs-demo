#####################################
# Security Group Settings
#####################################
resource "aws_security_group" "public-web" {
  name        = "${var.app_name}-public-web"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${var.app_name} Allow http & https traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "${var.app_name}-public-web"
    Group = "${var.app_name}"
  }
}

resource "aws_security_group" "internal-web" {
  name        = "${var.app_name}-internal-web"
  vpc_id      = "${aws_vpc.vpc.id}"
  description = "${var.app_name} Allow internal http & https traffic"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.root_segment}"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.root_segment}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name  = "${var.app_name}-internal-web"
    Group = "${var.app_name}"
  }
}
