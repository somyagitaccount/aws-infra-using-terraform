module "my_vpc" {
    source = "./modules/VPC"

    //same variable as networkvars = 
    VPC_CIDR = var.VPC_CIDR
    tenancy = "default"
    //VPC_ID = aws_vpc.tf-vpc.id
    VPC_ID = module.my_vpc.VPC_ID

    Public_Subnet_Range = var.Public_Subnet_Range
    Public_Subnet_Range1 = var.Public_Subnet_Range1
    Private_Subnet_Range = var.Private_Subnet_Range

}

module "my_ec2_public_0" {
    source = "./modules/EC2"

    EC2_Type = "t2.micro"
    my_subnet_id = module.my_vpc.public_subnet_id_1
    my_sg_id = [module.my_sg.SG_ID]
    //private_subnet_id = module.my_vpc.private_subnet_id
    ec2_tag = {
        "Name"        = "public_serve-1"
         type         = "public"
    }
}

module "my_ec2_public_1" {
    source = "./modules/EC2"

    EC2_Type = "t2.micro"
    //my_subnet_id = module.my_public_subnet_2
    my_subnet_id = module.my_vpc.public_subnet_id_2
    my_sg_id = [module.my_sg.SG_ID]
    //private_subnet_id = module.my_vpc.private_subnet_id
    ec2_tag = {
        "Name"        = "public_server-2"
         type         = "public"
    }
}


    
module "my_ec2_private" {
    source = "./modules/EC2"
    
    EC2_Type = "t2.micro"   //doubt
    my_subnet_id = module.my_vpc.private_subnet_id
    //public_subnet_id = module.my_vpc.public_subnet_id
    my_sg_id = [module.my_sg.SG_ID]
    ec2_tag = {
        "Name"        = "private_server"
         type         = "private"
    }
    //depends_on = [module.my_sg]
}

module "my_sg" {
    source = "./modules/VPC/SG"

    my_vpc_id = module.my_vpc.VPC_ID

}

 module "my_lb" {
    source = "./modules/LoadBalancer"

    Lb_SG = [module.my_sg.SG_ID]
    Lb_subnets = [module.my_vpc.public_subnet_id_1, module.my_vpc.public_subnet_id_2]
    Lb_Vpc_Id = module.my_vpc.VPC_ID
    TG_ARN = module.my_lb.Lb_TG_ARN
    TG_ID = module.my_ec2_public_0.instanceID
    
}



    