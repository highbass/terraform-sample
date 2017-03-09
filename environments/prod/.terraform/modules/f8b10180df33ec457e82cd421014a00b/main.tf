// Security Group Resource for Module
resource "aws_security_group" "sg_mysql" {
    name = "${var.environment}_sg_mysql"
    description = "${var.environment} mysql security group"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.environment}-sg-mysql"
      Environment =  "${var.environment}"
    }

    // allows traffic from the SG itself for tcp
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        self = true
    }

    // allows traffic from the SG itself for udp
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "udp"
        self = true
    }

    // allow traffic for TCP 22
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 3306
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

}
