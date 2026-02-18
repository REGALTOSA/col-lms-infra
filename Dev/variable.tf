variable "col_lms_cidr" {
  default = "10.0.0.0/16"
  type = string
}

variable "availability_zone" {
  default = ["ap-south-1a","ap-south-1b"]
  type = list(string)
  
}