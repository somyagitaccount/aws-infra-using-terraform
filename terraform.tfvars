VPC_CIDR = "192.168.0.0/16"

Public_Subnet_Range = "192.168.1.0/24"

Public_Subnet_Range1 = "192.168.3.0/24"

Private_Subnet_Range = "192.168.2.0/24"

zone = "eu-west-1a"

zone1 = "eu-west-1b"

Lb_subnets = ["aws_subnet.public-subnet_1.id", "aws_subnet.public-subnet_2.id"]
  
