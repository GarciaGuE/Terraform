terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami            = "ami-0136ddddd07f0584f" 
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}
