resource "aws_internet_gateway" "col_igw" {
    vpc_id = aws_vpc.col_lms_vpc.id

    tags = {
        Name = "igw-01"
    }
  
}