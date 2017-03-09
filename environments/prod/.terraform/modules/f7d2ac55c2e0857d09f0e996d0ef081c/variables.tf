// Module specific variables

variable "environment" { }
variable "name" { }

#Target Group Settings
variable "tg_port" { }
variable "tg_protocol" { }
variable "vpc_id" { }
variable "tg_health_check" { type = "map" }
