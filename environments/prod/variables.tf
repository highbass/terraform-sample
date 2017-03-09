provider "aws" {
  region = "${var.aws_region}"
  profile = "test"
}

variable "environment" {
  description = "Environment resources belong to"
}

variable "vpc_cidr_block" { }
variable "aws_region" { default = "ca-central-1" }

variable "availability_zones" { type = "list" }
variable "private_subnets" { type = "list" }
variable "public_subnets" { type = "list" }

variable "cert_arn" { }

variable "ami" { type = "map" }

variable "key_name" { }

variable "rds_monitoring_role_arn" { }
