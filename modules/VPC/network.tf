#Vpc creation
resource "aws_vpc" "tf-vpc" {
  cidr_block       = var.VPC_CIDR
  instance_tenancy = var.tenancy

  tags = {
    Name = "tf-vpc"
  }
}

#Public subnet creation

resource "aws_subnet" "public-subnet_1" {
  
  vpc_id = aws_vpc.tf-vpc.id
  cidr_block = var.Public_Subnet_Range
  map_public_ip_on_launch = true
  availability_zone = var.zone
  tags = {
    Name = "Public-Subnet_1"
  }
}


resource "aws_subnet" "public-subnet_2" {
  
  vpc_id = aws_vpc.tf-vpc.id
  cidr_block = var.Public_Subnet_Range1
  map_public_ip_on_launch = true
  availability_zone = var.zone1
  tags = {
    Name = "Public-Subnet_2"
  }
}

# resource "aws_subnet" "public-subnet_1" {
#   //vpc_id     = var.VPC_ID
#   vpc_id = aws_vpc.tf-vpc.id
#   //count = length(var.Public_Subnet_Range)
#   cidr_block = var.Public_Subnet_Range
#   map_public_ip_on_launch = "true"
#   availability_zone = "eu-west-1a"
#   //availability_zone = data.aws_availability_zones.available.names[count.index]
  
#   tags = {
#     Name = "public-subnet_1"
#   }
# }

#Internet gateway creation
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "igw"
  }
}

#Public route table creation
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

#Associate subnet into route table.
resource "aws_route_table_association" "public-1-a" {
  subnet_id      = aws_subnet.public-subnet_1.id
  route_table_id = aws_route_table.public-route-table.id
}

#Private subnet creation
resource "aws_subnet" "private-subnet_2" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = var.Private_Subnet_Range
  map_public_ip_on_launch = "false"
  availability_zone = var.zone

  tags = {  
    Name = "private-subnet_2"
  }
}

#Elastic IP for NAT gateway
resource "aws_eip" "nat" {
  vpc      = true
}

#NAT gateway creation
resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet_1.id

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}

#Private route table creation
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "private-route-table"
  }
}

#Associate subnet into route table.
resource "aws_route_table_association" "private-1-a" {
  subnet_id      = aws_subnet.private-subnet_2.id
  route_table_id = aws_route_table.private-route-table.id
}

output "VPC_ID" {
  value = aws_vpc.tf-vpc.id
}

output "public_subnet_id_1" {
  
  value = aws_subnet.public-subnet_1.id
}

output "public_subnet_id_2" {
  
  value = aws_subnet.public-subnet_2.id
}

output "private_subnet_id" {
  value = aws_subnet.private-subnet_2.id
}




