data "aws_ssm_parameter" "ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_launch_template" "lt_01" {
  instance_type = var.instance_type
  image_id      = data.aws_ssm_parameter.ami.value

  network_interfaces {
    associate_public_ip_address = true
    security_groups    = [aws_security_group.ec2_01.id]
  }

  tags = {
    Name = "lt-project-01"
  }
}