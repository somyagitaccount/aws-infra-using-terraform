terraform {
  backend "s3" {
    bucket = "state-file-bucket-01"
    key    = "myterraformstatefile"
    region = "eu-west-1"
  }
}


provider "aws" {
    region = var.AWS_Region

}