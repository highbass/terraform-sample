// Output ID of sg_redis SG we made
output "security_group_id" {
  value = "${aws_security_group.main_security_group.id}"
}
