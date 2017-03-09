// Output the ID of the EC2 instance created
output "target_group_arn" {
  value = "${aws_alb_target_group.default.arn}"
}
