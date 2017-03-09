// Output the ID of the EC2 instance created
output "alb_listener_arn" {
  value = "${aws_alb_listener.default.arn}"
}
