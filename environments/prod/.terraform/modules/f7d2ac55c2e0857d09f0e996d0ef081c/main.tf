resource "aws_alb_target_group" "default" {
  name     = "${var.environment}-${var.name}-targetgroup"
  port     = "${var.tg_port}"
  protocol = "${var.tg_protocol}"
  vpc_id   = "${var.vpc_id}"
  health_check {
    healthy_threshold = "${var.tg_health_check["healthy_threshold"]}"
    interval = "${var.tg_health_check["interval"]}"
    matcher = "${var.tg_health_check["matcher"]}"
    path = "${var.tg_health_check["path"]}"
    port = "${var.tg_health_check["port"]}"
    protocol = "${var.tg_health_check["protocol"]}"
    timeout = "${var.tg_health_check["timeout"]}"
    unhealthy_threshold = "${var.tg_health_check["unhealthy_threshold"]}"
  }
  tags {
    "Name" = "${var.environment}-${var.name}-targetgroup"
    "Environment" = "${var.environment}"
  }
}
