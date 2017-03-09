module "vpc"{
  source = "./../../modules/vpc"

  cidr = "${var.vpc_cidr_block}"
  public_subnets = "${var.public_subnets}"
  private_subnets = "${var.private_subnets}"

  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  azs   = "${var.availability_zones}"
  environment = "${var.environment}"
}
