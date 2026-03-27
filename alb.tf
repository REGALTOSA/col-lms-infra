#alb security group

resource "aws_security_group" "alb_sg" {
    vpc_id = aws_vpc.col_lms_vpc.id

    
    ingress {
        from_port = var.https_port
        to_port = var.https_port
        protocol = "tcp"
        cidr_blocks = [ var.all_traffic ]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [ var.all_traffic ]
    }
    tags = {
      Name = "alb-sg-01"
    }
  
}

resource "aws_lb" "alb-project-01" {
    internal = false
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb_sg.id ]
    subnets = [ aws_subnet.col_lms_pub_sub_01.id, aws_subnet.col_lms_pub_sub_02.id ]

    tags = {
      Name ="alb-01"
    }
    # target group    
   
  
}
resource "aws_lb_target_group" "main" {
    port = var.http_port
    protocol = "HTTP"
    vpc_id = aws_vpc.col_lms_vpc.id
    target_type = "ip"


    health_check {
      path = "/"
      protocol = "HTTP"
      interval = 30
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
    }
    tags = {
      Name = "alb-tg"
    } 
}

resource "aws_lb_listener" "HTTP" {
    load_balancer_arn = aws_lb.alb-project-01.arn 
    port = var.http_port
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.main.arn
}

}