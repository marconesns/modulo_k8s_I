resource "aws_key_pair" "chaveSSH"{
    key_name      = var.chave
    public_key    = file("${var.chave}.pub")
}

resource "aws_vpc" "vpc-k8s" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "subnet-k8s" {
  vpc_id = aws_vpc.vpc-k8s.id
  cidr_block = "172.16.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "subnet-k8s"
  }
}

resource "aws_internet_gateway" "igw-k8s" {
  vpc_id = aws_vpc.vpc-k8s.id
  tags = {
    Name = "igw-k8s"
  }
}

# resource "aws_route" "internet_gateway" {
#   destination_cidr_block = "0.0.0.0/0"
#   route_table_id = aws_route_table.rt-k8s.id
#   gateway_id = aws_internet_gateway.igw-k8s.id
# }

resource "aws_route_table" "rt-k8s" {
  vpc_id = aws_vpc.vpc-k8s.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-k8s.id
  }  
  tags = {
    Name = "rt-k8s"
  }
}

resource "aws_route_table_association" "rt_association-k8s" {
  subnet_id = aws_subnet.subnet-k8s.id
  route_table_id = aws_route_table.rt-k8s.id
}
 