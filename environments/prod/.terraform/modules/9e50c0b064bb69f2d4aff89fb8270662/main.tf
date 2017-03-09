resource "aws_alb" "alb" {
  name            = "${var.environment}-${var.name}-alb"
  internal        = "${var.alb_internal}"
  security_groups = ["${var.alb_security_groups}"]
  subnets         = ["${var.alb_subnet_az}"]

  enable_deletion_protection = true

  tags {
    Name = "${var.environment}-${var.name}-alb"
    Environment = "${var.environment}"
  }
}
