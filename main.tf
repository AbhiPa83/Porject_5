provider "aws" {
  region = var.region
}

module "Private_VPC" {
  source = "./Modules/Private_VPC"
  region = var.region
  private_vpc_name = var.private_vpc_name
  private_vpc_cidr = var.private_vpc_cidr
  privatevpc_public_subnet_az1_cidr = var.privatevpc_public_subnet_az1_cidr
  privatevpc_public_subnet_az2_cidr = var.privatevpc_public_subnet_az2_cidr
  privatevpc_private_subnet_az1_cidr = var.privatevpc_private_subnet_az1_cidr
  privatevpc_private_subnet_az2_cidr = var.privatevpc_private_subnet_az2_cidr
  
}

module "Public_VPC" {
  source = "./Modules/Public_VPC"
  region = var.region
  public_vpc_name = var.public_vpc_name
  public_vpc_cidr = var.public_vpc_cidr
  publicvpc_public_subnet_az1_cidr = var.publicvpc_public_subnet_az1_cidr
  publicvpc_public_subnet_az2_cidr = var.publicvpc_public_subnet_az2_cidr
  publicvpc_public_route_table_public_cidr = var.publicvpc_public_route_table_public_cidr
  publicvpc_private_subnet_az1_cidr = var.publicvpc_private_subnet_az1_cidr
  publicvpc_private_subnet_az2_cidr = var.publicvpc_private_subnet_az2_cidr
}

resource "aws_vpc_peering_connection" "public_to_private" {
  peer_vpc_id   = aws_vpc.private_vpc.id
  vpc_id        = aws_vpc.public_vpc.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between public and private"
  }
}



