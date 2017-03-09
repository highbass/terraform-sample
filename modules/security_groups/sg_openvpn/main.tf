//will secure this after... for testing a bit more laxed

resource "aws_security_group" "openvpn_sg" {
    name = "${var.environment}_sg_openvpn"
    description = "${var.environment} openvpn security group"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.environment}-sg-openvpn"
      Environment =  "${var.environment}"
    }

    // allows traffic from the SG itself
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    // allow traffic for internal up block
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.source_cidr_block}"]
        self = false
    }

    // allow traffic from external for Openvpn
    ingress {
        from_port = 0
        to_port = 1194
        protocol = "udp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // allow traffic from external for 943
    ingress {
        from_port = 0
        to_port = 943
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // allow traffic from external for 443
    ingress {
        from_port = 0
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // allow traffic from external for ssh
    ingress {
        from_port = 0
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    // outbound internet access
    egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
