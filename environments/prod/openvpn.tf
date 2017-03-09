module "ec2_oepnvpn" {
  source = "./../../modules/ec2"
  instance_name = "openvpn"
  environment = "${var.environment}"
  ami_id = "ami-24ad1f40"
  key_name = "${var.key_name}"
  security_groups = "${module.sg_openvpn.security_group_id}"
  number_of_instances = 1
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  instance_type = "t2.micro"
}

module "eip_oepnvpn" {
  source = "./../../modules/eip"
  eip_instance_id = "${module.ec2_oepnvpn.ec2_instance_id}"
}
