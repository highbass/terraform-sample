// Security Group Resource for Module
resource "aws_security_group" "sg_web" {
    name = "${var.environment}-sg-web"
    description = "${var.environment} web (http/https) security group"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.environment}-sg-web"
      Environment =  "${var.environment}"
    }

    // allows traffic from the SG itself for tcp
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    // allow traffic for TCP 80
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // allow traffic for TCP 443
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
