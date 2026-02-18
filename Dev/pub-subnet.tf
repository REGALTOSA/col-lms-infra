resource "aws_subnet" "col_lms_pub_sub-01" {
  vpc_id = aws_vpc.col_lms_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone[0]

  tags = {
    Name = var.sub-name1[0]
  }
}

resource "aws_subnet" "col_lms_pub_sub-02" {
    vpc_id = aws_vpc.col_lms_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.availability_zone[1]
  
}