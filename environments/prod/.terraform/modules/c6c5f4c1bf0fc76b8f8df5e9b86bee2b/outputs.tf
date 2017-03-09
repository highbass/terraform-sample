// Output the ID of the EC2 instance created
output "eip_allocation_id" {
  value = "${aws_eip.default.id}"
}
