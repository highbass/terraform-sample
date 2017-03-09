resource "aws_alb_listener" "default" {
   load_balancer_arn = "${var.lis_loadbalancer_arn}"
   port = "${var.lis_port}"
   protocol = "${var.lis_protocol}"
   ssl_policy = "${var.lis_sslPolicy}"
   certificate_arn = "${var.lis_cert_arn}"

   default_action {
     target_group_arn = "${var.lis_targetgroup_arn}"
     type = "forward"
   }
}
