// EC2 Instance Resource for Module
resource "aws_instance" "ec2_instance" {

    ami = "${var.ami_id}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids = ["${var.security_groups}"]
    key_name = "${var.key_name}"

    tags {
        Name = "${var.environment}_${var.instance_name}"
        Environment = "${var.environment}"
    }
}
