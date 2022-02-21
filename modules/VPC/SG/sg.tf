#Security group creation
resource "aws_security_group" "test_sg_1" {
  name        = "test_sg_1"
  //vpc_id = var.VPC_ID
  vpc_id = var.my_vpc_id
  description = "Terraform security group"

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

   ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = "test_sg_1"
  }
}

output "SG_ID" {
  value = aws_security_group.test_sg_1.id
  
}

