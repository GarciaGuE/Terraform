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
  region     = "eu-west-1"
}

resource "aws_instance" "platzi-instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags          = var.tags
  security_groups = [
    "${aws_security_group.allow_ssh.name}"
  ]
  # If the private key is already in the machine, this is not needed
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  connection {
    type        = connection.value.type
    host        = self.public_ip
    user        = connection.value.user
    private_key = file("") # Here goes the path to the private key
    timeout     = connection.value.timeout
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = var.sg_name
  description = "Allow ssh inbound traffic"

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description      = ""
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = []
    }
  }
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description      = ""
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = []
    }
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "" # Here goes the public key, write it in the same line
}


