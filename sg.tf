resource "aws_security_group" "ec2_01" {
    vpc_id = aws_vpc.col_lms_vpc.id




#ssh allow
ingress {
description = "SSH"
from_port = var.ssh_port
to_port = var.ssh_port
protocol = "tcp"
cidr_blocks = [var.all_traffic]
}
#http allow


ingress {
    description = "HTTP"
    from_port = var.http_port
    to_port = var.http_port
    protocol = "tcp"
    cidr_blocks = [var.all_traffic]
}
# HTTPS Allow
  ingress {
    description = "HTTPS"
    from_port   = var.https_port
    to_port     = var.https_port
    protocol    = "tcp"
    cidr_blocks = [var.all_traffic]
  }
  # Outbound - Sab Allow
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_traffic]
  }

  tags = {
    Name = "ec2-sg-01"
  }
}