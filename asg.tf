resource "aws_autoscaling_group" "asg-01" {
    min_size = var.asg_min
    max_size = var.asg_max
    desired_capacity = var.asg_desired
    vpc_zone_identifier = [ aws_subnet.col_lms_pub_sub_01.id,aws_subnet.col_lms_pub_sub_02.id ]


    launch_template {
      id = aws_launch_template.lt_01.id
      version = "$Latest"
    }
}

