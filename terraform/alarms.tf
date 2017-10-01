resource "aws_autoscaling_policy" "scale_to_zero" {
  name                   = "scale-to-zero"
  scaling_adjustment     = 0
  adjustment_type        = "ExactCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.build_agents.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpu_scale_down" {
  alarm_name          = "builders-cpu"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "5"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "0"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.build_agents.name}"
  }

  alarm_description = "Alarm to monitor unused instances"
  alarm_actions     = ["${aws_autoscaling_policy.scale_to_zero.arn}"]
}
