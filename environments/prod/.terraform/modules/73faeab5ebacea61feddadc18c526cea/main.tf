// Security Group Resource for Module
resource "aws_security_group" "main_security_group" {
    name = "${var.environment}-sg-redis"
    description = "${var.environment} redis security group"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.environment}-sg-redis"
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

    // allow traffic for TCP 6379 (Redis)
    ingress {
        from_port = 6379
        to_port = 6379
        protocol = "tcp"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

}
