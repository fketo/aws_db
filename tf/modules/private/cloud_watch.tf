resource "aws_cloudwatch_metric_alarm" "cpuutilization" {
  count               =  var.with_ec2 == true ? length(var.subnet_cidrs) * var.ec2["instance_count"] : 0
  alarm_name          = "${element(split(",", join(",", aws_instance.priv[*].id)), count.index)}-status-check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "20"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions = {
    InstanceId = element(aws_instance.priv[*].id, count.index)
  }
}

resource "aws_cloudwatch_metric_alarm" "statuscheckfailed" {
  count               =  var.with_ec2 == true ? length(var.subnet_cidrs) * var.ec2["instance_count"] : 0
  alarm_name          = "${element(split(",", join(",", aws_instance.priv[*].id)), count.index)}-status-check"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "StatusCheckFailed"
  namespace           = "EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "1"
  alarm_description   = "This metric monitors ec2 status check."

  dimensions = {
    InstanceId = element(aws_instance.priv[*].id, count.index)
  }
}
