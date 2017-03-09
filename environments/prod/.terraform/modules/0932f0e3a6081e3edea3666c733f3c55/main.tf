resource "aws_db_instance" "main_rds_instance" {
    identifier = "${var.rds_instance_name}"
    allocated_storage = "${var.rds_allocated_storage}"
    engine = "${var.rds_engine_type}"
    engine_version = "${var.rds_engine_version}"
    instance_class = "${var.rds_instance_class}"
    name = "${var.database_name}"
    username = "${var.database_user}"
    password = "${var.database_password}"
    // Because we're assuming a VPC, we use this option, but only one SG id
    vpc_security_group_ids = ["${var.rds_security_group_id}"]
    // We're creating a subnet group in the module and passing in the name
    db_subnet_group_name = "${aws_db_subnet_group.main_db_subnet_group.name}"
    // We want the multi-az setting to be toggleable, but off by default
    multi_az = "${var.rds_is_multi_az}"
    storage_type = "${var.rds_storage_type}"
    // backup strategy
    backup_retention_period = "${var.rds_backup_retention_period}"
    monitoring_role_arn = "${var.rds_monitoring_role_arn}"
    monitoring_interval = 30

    tags {
      Name = "${var.environment}_mysql_rds"
      Environment = "${var.environment}"
    }
}

resource "aws_db_subnet_group" "main_db_subnet_group" {
    name = "${var.rds_instance_name}_subnetgrp"
    description = "${var.environment} RDS subnet group"
    subnet_ids = ["${var.rds_subnet_az}"]
    tags {
      Name = "${var.environment}_rds"
      Environment = "${var.environment}"
    }
}
