// Module specific variables

variable "environment" { }
variable "name" { }

#Application Load balancer settings
variable "alb_security_groups" { }
variable "alb_subnet_az" { type = "list" }
variable "alb_internal" { default = "False" }
