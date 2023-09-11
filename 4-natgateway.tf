resource "aws_eip" "nat1" {
    depends_on = [ aws_internet_gateway.main ]

    tags = {
      Name = "nat1"
    }
}

resource "aws_eip" "nat2" {
    depends_on = [ aws_internet_gateway.main ]

    tags = {
      Name = "nat2"
    }
}
resource "aws_nat_gateway" "qw1" {
    allocation_id = aws_eip.nat1.id
    subnet_id     = aws_subnet.public-us-east-1a.id

    tags = {
        Name = "NAT1"
    }
   
}

resource "aws_nat_gateway" "qw2" {
    allocation_id = aws_eip.nat2.id
    subnet_id     = aws_subnet.public-us-east-1b.id

    tags = {
        Name = "NAT2"
    }
   
}