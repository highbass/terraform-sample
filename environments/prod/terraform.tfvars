######################
## General Settings ##
######################
environment = "prod"

key_name = "prod"

##################
## VPC SETTINGS ##
##################

aws_region = "ca-central-1"
availability_zones = ["ca-central-1a", "ca-central-1b"]
vpc_cidr_block = "10.0.0.0/16"
private_subnets = ["10.0.64.0/24", "10.0.65.0/24"]
public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

# cert ARN
cert_arn = "XXXX"

# ami for PUMA - Bake
ami = {
  puma = "ami-86a21fe2"
}

# RDS Monitoring ARN (creation not handled by terraform)
rds_monitoring_role_arn = "rds-monitoring-role"
