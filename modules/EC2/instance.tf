resource "aws_instance" "ec2_instance" {
  //ami = lookup(var.AMIS, var.AWS_Region)
  ami = var.AMI_ID
  instance_type = var.EC2_Type
  subnet_id = var.my_subnet_id //doubt
  //subnet_id = var.private_sub
  associate_public_ip_address  = "true"
  key_name = "aws_infra_keyPair"
  vpc_security_group_ids = var.my_sg_id
  tags = var.ec2_tag

  user_data = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install httpd -y
            sudo systemctl start httpd.service
            sudo bash -c 'echo this is my terraform module >/var/www/html/index.html'
            EOF
  //vpc_security_group_ids = [aws_security_group.test_sg_1.id] //doubt
  
}

 output "instanceID" {
    value = aws_instance.ec2_instance.id
  }

# resource "aws_instance" "tf-private_subnet_instance" {
#   //ami = lookup(var.AMIS, var.AWS_Region)
#   ami = var.AMI_ID
#   instance_type = var.EC2_Type
#   subnet_id = var.private_subnet_id
#   tags = {
#     Name = "Private instance" 
#   }
#   vpc_security_group_ids = [aws_security_group.test_sg_1.id]
  
# }





