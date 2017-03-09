// MYSQL Provisioning
module "alb_puma" {
  source = "./../../modules/alb"

  //alb Settings
  alb_subnet_az   = "${module.vpc.public_subnets}"
  alb_security_groups = "${module.sg_web.security_group_id}"

  environment = "${var.environment}"
  name = "puma"
}

module "alb_puma_tg" {
  source = "./../../modules/alb_targetgroup"

 //Target Group Settings
  tg_port = "80"
  tg_protocol = "HTTP"
  tg_health_check = {
    healthy_threshold = "5"
    interval = "30"
    matcher = "200,301,302"
    path = "/"
    port = "80"
    protocol = "HTTP"
    timeout = "5"
    unhealthy_threshold = "2"
  }

  vpc_id = "${module.vpc.vpc_id}"
  environment = "${var.environment}"
  name = "puma"
}

module "alb_puma_listener_HTTP" {
  source = "./../../modules/alb_listener"

  //alb Listener
  lis_loadbalancer_arn = "${module.alb_puma.alb_arn}"
  lis_port = "80"
  lis_protocol = "HTTP"
  lis_targetgroup_arn = "${module.alb_puma_tg.target_group_arn}"
}

module "alb_puma_listener_HTTPS" {
  source = "./../../modules/alb_listener_https"
  create_ssl = true
  //alb Listener
  lis_loadbalancer_arn = "${module.alb_puma.alb_arn}"
  lis_port = "443"
  lis_protocol = "HTTPS"
  lis_cert_arn = "${var.cert_arn}"
  lis_targetgroup_arn = "${module.alb_puma_tg.target_group_arn}"
}
