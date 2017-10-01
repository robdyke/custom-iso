data "template_file" "user_data" {
  template = "${file("user_data.sh")}"
}

resource "aws_launch_configuration" "build_agent_configuration" {
  image_id      = "ami-785db401"
  instance_type = "c4.xlarge"
  spot_price    = "0.07"

  iam_instance_profile = "${aws_iam_instance_profile.build_agent_profile.arn}"
  key_name             = "compute-instance-20170930"
  user_data            = "${data.template_file.user_data.rendered}"

  security_groups = [
    "${aws_security_group.build_agent_security_group.name}",
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "build_agents" {
  availability_zones   = ["eu-west-1a"]
  name                 = "build-agents"
  launch_configuration = "${aws_launch_configuration.build_agent_configuration.name}"

  max_size         = 1
  min_size         = 0
  desired_capacity = 0

  lifecycle {
    create_before_destroy = true
  }
}
