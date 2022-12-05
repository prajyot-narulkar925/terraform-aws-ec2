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
  instance_type = "t3.micro"
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

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-prajyot-demo"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


resource "aws_elasticsearch_domain" "prajyot-example" {
  domain_name           = var.domain
  elasticsearch_version = "7.10"
  cluster_config {
    instance_type = var.instance_type
    instance_count = 1
  }
  ebs_options {
    ebs_enabled = var.ebs_volume_size > 0 ? true : false
    volume_size = var.ebs_volume_size
    volume_type = var.volume_type
  }

  tags = {
    Domain = var.tag_domain
  }
}

output "arn" {
    value = aws_elasticsearch_domain.prajyot-es.arn
}
output "domain_id" {
    value = aws_elasticsearch_domain.prajyot-es.domain_id
}
output "domain_name" {
    value = aws_elasticsearch_domain.prajyot-es.domain_name
}
output "endpoint" {
    value = aws_elasticsearch_domain.prajyot-es.endpoint
}

output "aws_instance_data"{
    value = aws_instance.example
}

output "type" {
  value = "${aws_instance.example.instance_type}"
}
