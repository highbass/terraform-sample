// Module specific variables
variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}

variable "sg_group" {
  description = "this should be the LB sg"
}

variable "environment" {}
