resource "aws_route_table" "public_rt-01" {
  vpc_id = aws_vpc.col_lms_vpc.id


   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.col_igw.id

 }
 tags = {
   Name = "aws-rt-01"
 }
}
resource "aws_route_table" "rt-2" {
    vpc_id = aws_vpc.col_lms_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.col_igw.id
    }
  tags = {
    Name = "aws-rt-02"
  }
}
  resource "aws_route_table_association" "ass-sub-01" {
    route_table_id = aws_route_table.public_rt-01.id
    subnet_id = aws_subnet.col_lms_pub_sub_01.id
  }
  resource "aws_route_table_association" "ass-sub-02" {
    route_table_id = aws_route_table.rt-2.id
    subnet_id = aws_subnet.col_lms_pub_sub_02.id
    
  }

 
    
  