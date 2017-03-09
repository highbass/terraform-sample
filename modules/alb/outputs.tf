// Output the ID of the EC2 instance created
output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}

output "alb_dns" {
  value = "${aws_alb.alb.dns_name}"
}

output "alb_zoneid" {
  value = "${aws_alb.alb.zone_id}"
}

output "alb_name" {
  value = "${aws_alb.alb.name}"
}
