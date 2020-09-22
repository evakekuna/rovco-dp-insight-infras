# Network Setup: VPC, Subnet, IGW, Routes | network.tf
data "aws_availability_zones" "aws-az" {
  state = "available"
}

# create vpc
resource "aws_vpc" "aws-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.api_app_name}-${var.env}-vpc"
    Environment = var.env
  }
}

# create subnets
resource "aws_subnet" "aws-subnet" {
  count = length(data.aws_availability_zones.aws-az.names)
  vpc_id = aws_vpc.aws-vpc.id
  cidr_block = cidrsubnet(aws_vpc.aws-vpc.cidr_block, 8, count.index + 1)
  availability_zone = data.aws_availability_zones.aws-az.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.api_app_name}-${var.env}-subnet-${count.index + 1}"
    Environment = var.env
  }
}

# create internet gateway
resource "aws_internet_gateway" "aws-igw" {
  vpc_id = aws_vpc.aws-vpc.id
  tags = {
    Name = "${var.api_app_name}-${var.env}-igw"
    Environment = var.env
  }
}

# create routes
resource "aws_route_table" "aws-route-table" {
  vpc_id = aws_vpc.aws-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws-igw.id
  }
  tags = {
    Name = "${var.api_app_name}-${var.env}-route-table"
    Environment = var.env
  }
}
resource "aws_main_route_table_association" "aws-route-table-association" {
  vpc_id = aws_vpc.aws-vpc.id
  route_table_id = aws_route_table.aws-route-table.id
}