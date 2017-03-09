variable "environment" {}

variable "elc_group_id" {}
variable "elc_subnet_az" { type = "list" }
variable "elc_security_groups" {}
variable "elc_group_description" {}
variable "elc_automatic_failover_enabled" { default = "false" }
variable "elc_desired_clusters" { default = "1" }
variable "elc_instance_type" { default = "cache.t2.micro" }
variable "elc_engine_version" { default = "3.2.4" }
