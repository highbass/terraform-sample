data "aws_iam_policy_document" "default" {
      statement {
              actions = [
                  "s3:PutObject",
                  "s3:GetObject",
                  "s3:ListObject"
              ]
              effect = "Allow"
              resources = [
                  "arn:aws:s3:::${var.environment}.test.uploads/*",
                  "arn:aws:s3:::${var.environment}.test.uploads",
                  "arn:aws:s3:::${var.environment}.test.deploy/*",
                  "arn:aws:s3:::${var.environment}.test.deploy"
              ]
      }
}


resource "aws_iam_policy" "policy" {
    name = "${var.environment}-puma-policy"
    path = "/"
    description = "Policy to access s3 buckets"
    policy = "${data.aws_iam_policy_document.default.json}"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
          type = "Service"
          identifiers = ["ec2.amazonaws.com"]
        }
        effect = "Allow"
    }
}

resource "aws_iam_role" "role" {
    name = "${var.environment}-puma-role"
    path = "/"
    assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
    role = "${aws_iam_role.role.name}"
    policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "profile" {
    name = "${var.environment}-puma-profile"
    roles = ["${aws_iam_role.role.name}"]
}

module "asg_puma"{
  source = "./../../modules/asg"

  environment = "${var.environment}"
  name = "puma"

  // Lunch Configuration Settings
  lc_ami = "${var.ami["puma"]}"
  lc_instance_type = "t2.micro"
  lc_iam_profile = "${aws_iam_instance_profile.profile.name}"
  lc_key_name = "${var.key_name}"
  lc_security_groups = ["${module.sg_puma.security_group_id}"]
  lc_monitoring = "True"

  // Autoscaling group
  asg_max_size = "0"
  asg_min_size = "0"
  asg_health_check_grace_period = "300"
  asg_health_check_type = "ELB"
  asg_desired_capacity = "0"
  asg_subnet_az  = "${module.vpc.public_subnets}"
  asg_target_group_arns = ["${module.alb_puma_tg.target_group_arn}"]

}
