resource "aws_launch_configuration" "default" {
  name_prefix             = "${var.environment}-${var.name}-LaunchConfiguration"
  image_id                = "${var.lc_ami}"
  instance_type           = "${var.lc_instance_type}"
  iam_instance_profile    = "${var.lc_iam_profile}"
  key_name                = "${var.lc_key_name}"
  security_groups         = ["${var.lc_security_groups}"]
  enable_monitoring       = "${var.lc_monitoring}"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "default" {
  name                      = "${var.environment}-${var.name}-autoscaling"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  health_check_grace_period = "${var.asg_health_check_grace_period}"
  health_check_type         = "${var.asg_health_check_type}"
  desired_capacity          = "${var.asg_desired_capacity}"
  vpc_zone_identifier       = ["${var.asg_subnet_az}"]
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.default.name}"

  target_group_arns         = ["${var.asg_target_group_arns}"]

  //load_balancers = ["${var.asg_loadbalancer}"]

  tag {
    key = "Name"
    value = "${var.environment}_${var.name}"
    propagate_at_launch = true
  }
  tag {
    key = "Environment"
    value = "${var.environment}"
    propagate_at_launch = true
  }
}
