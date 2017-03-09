// MYSQL Provisioning
module "mysql"{
  source = "./../../modules/rds"
  rds_instance_name = "${var.environment}-test"
  rds_engine_type = "mysql"
  rds_engine_version = "5.7.11"
  rds_instance_class = "db.t2.small"

  database_name = "test"
  database_user = "test"
  database_password = "test"

  rds_security_group_id = "${module.sg_mysql.security_group_id}"

  rds_subnet_az   = "${module.vpc.private_subnets}"
  rds_is_multi_az = "true"
  rds_storage_type = "gp2"
  rds_allocated_storage = "20"
  rds_backup_retention_period = "7"
  rds_monitoring_role_arn = "${var.rds_monitoring_role_arn}"
  environment = "${var.environment}"
}
