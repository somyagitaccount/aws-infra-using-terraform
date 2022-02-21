variable "VPC_CIDR" {
    default = "10.0.0.0/16"
}

variable "tenancy" {
    default = "dedicated"
  
}

variable "VPC_ID" {}

variable "Public_Subnet_Range" {
    default = "10.1.0.0/24"
  
}

variable "Public_Subnet_Range1" {}

variable "Private_Subnet_Range" {
    default = "10.2.0.0/24"
  
}


variable "zone" {
    default = "eu-west-1a"
}

variable "zone1" {
    default = "eu-west-1b"
}



# variable "AZ" {
#     default = "eu-west-1a"
#   }