# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name
}

# IAM Role
resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task Definition 1
resource "aws_ecs_task_definition" "task_01" {
  family                   = "${var.project_name}-task-01"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name      = var.container_name_01
    image     = var.container_image
    essential = true
    portMappings = [{
      containerPort = var.container_port
      protocol      = "tcp"
    }]
  }])
}

# Task Definition 2
resource "aws_ecs_task_definition" "task_02" {
  family                   = "${var.project_name}-task-02"
  network_mode             = "awsvpc"
  requires_compatibilities = ["EC2"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  execution_role_arn       = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([{
    name      = var.container_name_02
    image     = var.container_image
    essential = true
    portMappings = [{
      containerPort = var.container_port
      protocol      = "tcp"
    }]
  }])
}

# ECS Security Group
resource "aws_security_group" "ecs_sg" {
  name   = "${var.project_name}-ecs-sg"
  vpc_id = aws_vpc.col_lms_vpc.id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_traffic]
  }
}

# ECS Service 1
resource "aws_ecs_service" "service_01" {
  name            = "${var.ecs_service_name}-01"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task_01.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "EC2"

  network_configuration {
    subnets          = [aws_subnet.col_lms_pub_sub_01.id, aws_subnet.col_lms_pub_sub_02.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = var.container_name_01
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.HTTP]
}

# ECS Service 2
resource "aws_ecs_service" "service_02" {
  name            = "${var.ecs_service_name}-02"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task_02.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "EC2"

  network_configuration {
    subnets          = [aws_subnet.col_lms_pub_sub_01.id, aws_subnet.col_lms_pub_sub_02.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = var.container_name_02
    container_port   = var.container_port
  }

  depends_on = [aws_lb_listener.HTTP]
}

