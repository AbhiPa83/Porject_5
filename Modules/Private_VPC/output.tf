output "region" {
  value = var.region
}

output "vpc_name" {
  value = aws_vpc.private_vpc.id
}

output "public_subnet_az1" {
  value = aws_subnet.privatevpc_public_subnet_az1.id
}

output "public_subnet_az2" {
  value = aws_subnet.privatevpc_public_subnet_az2.id
}

output "private_subnet_az1" {
  value = aws_subnet.privatevpc_private_subnet_az1.id
}

output "private_subnet_az2" {
  value = aws_subnet.privatevpc_private_subnet_az2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.private_internet_gateway
}