// Output ID of sg_web SG we made
output "security_group_id" {
  value = "${aws_security_group.sg_puma.id}"
}
