resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.qw1.id
      
    }
  

  tags = {
    Name = "private1"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.qw2.id  
    }
  tags = {
    Name = "private2"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
      cidr_block                 = "0.0.0.0/0"
      gateway_id                 = aws_internet_gateway.main.id
  }
  tags = {
    Name = "public"
  }
}

resource "aws_route_table_association" "private1" {
  route_table_id  = aws_route_table.private1.id
  subnet_id       = aws_subnet.private-us-east-1a.id
}

resource "aws_route_table_association" "private2" {
  route_table_id  = aws_route_table.private2.id
  subnet_id       = aws_subnet.private-us-east-1b.id
}

resource "aws_route_table_association" "public-1a" {
  route_table_id  = aws_route_table.public.id
  subnet_id       = aws_subnet.public-us-east-1a.id
}

resource "aws_route_table_association" "public-1b" {
  route_table_id  = aws_route_table.public.id
  subnet_id       = aws_subnet.public-us-east-1b.id
}