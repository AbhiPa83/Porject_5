# create vpc
resource "aws_vpc" "private_vpc" {
  cidr_block           = var.private_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.private_vpc_name}-vpc"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "private_internet_gateway" {
  vpc_id = aws_vpc.private_vpc.id

  tags = {
    Name = "${var.private_vpc_name}-igw"
  }
}

# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}

# create public subnet az1
resource "aws_subnet" "privatevpc_public_subnet_az1" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.privatevpc_public_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet az1"
  }
}

# create public subnet az2
resource "aws_subnet" "privatevpc_public_subnet_az2" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.privatevpc_public_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet az2"
  }
}

# create route table and add public route
resource "aws_route_table" "privatevpc_public_route_table" {
  vpc_id = aws_vpc.private_vpc.id

#  route {
#  cidr_block = var.route_table_public_cidr
#  gateway_id = aws_internet_gateway.internet_gateway.id
#}

  tags = {
    Name = "Public Route Table"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "privatevpc_public_subnet_az1_route_table_association" {
  subnet_id      = aws_subnet.privatevpc_public_subnet_az1.id
  route_table_id = aws_route_table.privatevpc_public_route_table.id
}
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "privatevpc_public_subnet_az2_route_table_association" {
  subnet_id      = aws_subnet.privatevpc_public_subnet_az2.id
  route_table_id = aws_route_table.privatevpc_public_route_table.id
}
}

# create private subnet az1
resource "aws_subnet" "privatevpc_private_subnet_az1" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.privatevpc_private_subnet_az1_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet az1"
  }
}

# create private subnet az2
resource "aws_subnet" "privatevpc_private_subnet_az2" {
  vpc_id                  = aws_vpc.private_vpc.id
  cidr_block              = var.privatevpc_private_subnet_az2_cidr
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet az2"
  }
}