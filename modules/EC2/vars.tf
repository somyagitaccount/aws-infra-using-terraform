variable "AWS_Region" {
    default = "eu-west-1"
}

# variable "AMIS" {
#     type = map
#     default = {
#         us-east-1 = "ami-0ed9277fb7eb570c9"
#         us-west-2 = "ami-00f7e5c52c0f43726"
#         eu-west-1 = "ami-04dd4500af104442f"

#     }
# }

variable "AMI_ID" {
  default = "ami-04dd4500af104442f"
}
variable "EC2_Type" {
    default     =  "t2.micro"
}

//variable "public_subnet_id" {}

//variable "private_subnet_id" {}

variable "my_subnet_id" {}

variable "my_sg_id" {}

variable "ec2_tag" {}

#  variable "public_ip" {
#   default = false
#  }

# variable my_key{
#     default      = "free-aws-key"
#     description  = "KMS key for Ec2 instance"
# }

