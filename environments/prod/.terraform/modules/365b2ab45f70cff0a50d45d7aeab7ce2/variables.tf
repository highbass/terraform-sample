// Module specific variables

#alb listener settings
variable "lis_protocol" { }
variable "lis_port" { }
variable "lis_loadbalancer_arn" { }
variable "lis_targetgroup_arn" { }
variable "lis_cert_arn" { default = "none" }
variable "lis_sslPolicy" { default = "ELBSecurityPolicy-2015-05" }
variable "create_ssl" { default = false }
