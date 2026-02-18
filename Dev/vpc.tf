resource "aws_vpc" "col_lms_vpc" {
cidr_block = var.col_lms_cidr
tags = {
  name = "col_lms_vpc-01"
}
  
}