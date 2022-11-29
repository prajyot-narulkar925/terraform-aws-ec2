terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.41.0"
    }
  }
}

provider "aws" {
  region     = "ap-south-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "example" {
  ami           = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  tags = {
    Name = "gitops-pipeline-deployment"
  }
  security_groups = ["test-security-group"]
}

resource "aws_security_group" "sg_test" {
  name = "test-security-group"

  #Incoming traffic
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["136.226.252.246/32"]
  }  
  #Outgoing traffic
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  resource "aws_s3_bucket" "test-storage" {
  bucket = "tf-test-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
