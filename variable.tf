variable "col_lms_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zone" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "sg_01" {
  type    = string
  default = "web-sg"
}

variable "ssh_port" {
  type    = number
  default = 22        # ✅ no quotes
}

variable "http_port" {
  type    = number
  default = 80        # ✅ no quotes
}

variable "https_port" {
  type    = number
  default = 443       # ✅ no quotes
}

variable "all_traffic" {
  type    = string
  default = "0.0.0.0/0"
}

variable "ami_id" {
  type    = string
  default = "ami-019715e0d74f695be"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "col-lms-key"
}

variable "alb_name" {
  type    = string
  default = "my-alb"
}

variable "tg_name" {
  type    = string
  default = "my-tg"
}

variable "asg_name" {
  type    = string
  default = "my-asg"
}

variable "asg_min" {
  type    = number
  default = 1
}

variable "asg_max" {
  type    = number
  default = 3
}

variable "asg_desired" {
  type    = number
  default = 2
}

variable "ecs_cluster_name" {
  type    = string
  default = "my-ecs-cluster"
}

variable "ecs_service_name" {
  type    = string
  default = "my-ecs-service"
}

variable "container_name_01" {
  type    = string
  default = "container-01"
}

variable "container_name_02" {
  type    = string
  default = "container-02"
}

variable "container_image" {
  type    = string
  default = "nginx:latest"
}

variable "container_port" {
  type    = number
  default = 80
}

variable "task_cpu" {
  type    = string
  default = "256"
}

variable "task_memory" {
  type    = string
  default = "512"
}

variable "ecs_desired_count" {
  type    = number
  default = 2
}

variable "project_name" {
  type    = string
  default = "col-lms"
}

variable "aws_region" {
  type    = string
  default = "ap-south-1"   # ✅ Added for S3 backend & provider
}

