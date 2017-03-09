// Module specific variables

variable "environment" { }
variable "name" { }

#Launch Configuration settings
variable "lc_ami" { }
variable "lc_instance_type" { }
variable "lc_iam_profile" { }
variable "lc_key_name" { }
variable "lc_security_groups" { type = "list" }
variable "lc_monitoring" { }

# Autoscaling group settings
variable "asg_max_size" { default = 0 }
variable "asg_min_size" { default = 0 }
variable "asg_health_check_grace_period" { default = 300 }
variable "asg_health_check_type" { default = "ELB" }
variable "asg_desired_capacity" { default = 0 }
variable "asg_subnet_az" { type = "list" }
variable "asg_target_group_arns" { type = "list" }
//variable "asg_loadbalancer" { type = "list" }
