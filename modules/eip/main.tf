resource "aws_eip" "default" {
  vpc = "${var.eip_vpc}"
  instance = "${var.eip_instance_id}"
}
