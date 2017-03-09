#
# ElastiCache resources
#
resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${lower(var.elc_group_id)}"
  replication_group_description = "${var.elc_group_description}"
  automatic_failover_enabled    = "${var.elc_automatic_failover_enabled}"
  number_cache_clusters         = "${var.elc_desired_clusters}"
  node_type                     = "${var.elc_instance_type}"
  engine_version                = "${var.elc_engine_version}"
  subnet_group_name             = "${aws_elasticache_subnet_group.default.name}"
  security_group_ids            = ["${var.elc_security_groups}"]
  port                          = "6379"

  tags {
    Name = "${var.environment}_elasticache_redis"
    Environment = "${var.environment}"
  }
}

resource "aws_elasticache_subnet_group" "default" {
    name = "${var.environment}-elasticache-redis-subnetgrp"
    description = "${var.environment} Elasticache Redis subnet group"
    subnet_ids = ["${var.elc_subnet_az}"]
}
