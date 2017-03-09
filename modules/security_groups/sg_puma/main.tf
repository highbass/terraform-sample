// Security Group Resource for Module
resource "aws_security_group" "sg_puma" {
    name = "${var.environment}-sg-puma"
    description = "${var.environment} puma (http/https) security group"
    vpc_id = "${var.vpc_id}"

    tags {
      Name = "${var.environment}-sg-puma"
      Environment =  "${var.environment}"
    }

    // allows all traffic from the SG itself
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }

    // allow all traffic for internal
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.source_cidr_block}"]
    }

    // allow traffic for TCP 80
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${var.sg_group}"]
    }
}
