// MYSQL Provisioning
module "redis"{
  source = "./../../modules/elasticache"
  elc_group_id = "${var.environment}-redis" 
  elc_group_description = "${var.environment} Replication group for Redis"
  elc_automatic_failover_enabled = "false"
  elc_desired_clusters = "2"
  elc_instance_type = "cache.t2.micro"
  elc_engine_version = "3.2.4"

  elc_subnet_az   = "${module.vpc.private_subnets}"
  elc_security_groups = "${module.sg_redis.security_group_id}"
  
  environment = "${var.environment}"
}
