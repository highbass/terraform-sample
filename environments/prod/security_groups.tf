module "sg_mysql" {
  source = "./../../modules/security_groups/sg_mysql"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.vpc_cidr_block}"
  environment = "${var.environment}"
}

module "sg_openvpn" {
  source = "./../../modules/security_groups/sg_openvpn"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.vpc_cidr_block}"
  environment = "${var.environment}"
}

module "sg_redis" {
  source = "./../../modules/security_groups/sg_redis"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.vpc_cidr_block}"
  environment = "${var.environment}"
}

module "sg_web" {
  source = "./../../modules/security_groups/sg_web"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "0.0.0.0/0"
  environment = "${var.environment}"
}

module "sg_puma" {
  source = "./../../modules/security_groups/sg_puma"
  vpc_id = "${module.vpc.vpc_id}"
  source_cidr_block = "${var.vpc_cidr_block}"
  environment = "${var.environment}"
  sg_group = "${module.sg_web.security_group_id}"
}
