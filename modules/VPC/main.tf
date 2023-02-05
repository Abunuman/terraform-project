#VPC MODULE : CREATING A VPC (called using ../modules/VPC)
resource "aws_vpc" "main_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.miniproj_name}-vpc"
  }
}

#Fetching for availability zone in the region using data source
data "aws_availability_zones" "AZ" {}

#Creating  public subnets

#Public subnet 1
resource "aws_subnet" "publicsubnet1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.pubsub1_cidr
  availability_zone       = data.aws_availability_zones.AZ.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet1"
  }
}

#Public subnet 2
resource "aws_subnet" "publicsubnet2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.pubsub2_cidr
  availability_zone       = data.aws_availability_zones.AZ.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet2"
  }
}



#Creating a route table 
resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Nexus-igw.id
  }

  tags = {
    Name = "public-route"
  }
}

#Creating a subnet association 
resource "aws_route_table_association" "sub_ass1" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_route_table_association" "sub_ass2" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.pub-route.id
}

#Creating an internet gateway (IGW)
resource "aws_internet_gateway" "Nexus-igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Nexus-IGW"
  }
}