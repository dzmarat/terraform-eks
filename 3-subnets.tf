resource "aws_subnet" "private-us-east-1a" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "192.168.0.0/19"
    #required
    availability_zone = "us-east-1a"

    #A map of tags to assign to the resource
    tags = {
        Name                            = "private-us-east-1a"
        "kubernetes.io/role/internal-elb" = 1
        "kubernetes.io/cluster/eks"      = "shared"
    }
  
}

resource "aws_subnet" "private-us-east-1b" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "192.168.64.0/19"
    availability_zone = "us-east-1b"

    tags = {
        "Name"                            = "private-us-east-1b"
        "kubernetes.io/role/internal-elb" = 1
        "kubernetes.io/cluster/eks"      = "shared"
    }
  
}

resource "aws_subnet" "public-us-east-1a" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "192.168.128.0/18"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        "Name"                           = "public-us-east-1a"
        "kubernetes.io/role/elb"         = 1
        "kubernetes.io/cluster/eks"      = "shared"
    }
  
}

resource "aws_subnet" "public-us-east-1b" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = "192.168.192.0/18"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
        "Name"                           = "public-us-east-1b"
        "kubernetes.io/role/elb"         = 1
        "kubernetes.io/cluster/eks"      = "shared"
    }
  
}