resource "aws_subnet" "col_lms_pub_sub_01" {
  vpc_id = aws_vpc.col_lms_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone[0]

  tags = {
    Name = "pub-sub-01"
  }
}

resource "aws_subnet" "col_lms_pub_sub_02" {
    vpc_id = aws_vpc.col_lms_vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.availability_zone[1]

    tags = {
      Name = "pub-sub-02"
    }

  
}