provider "aws" {
  region     = "ap-south-1"
  access_key = ""
  secret_key = ""
}

resource "aws_instance" "example" {
  ami           = "ami-074dc0a6f6c764218"
  instance_type = "t2.micro"
  tags = {
    Name = "gitops-deployment"
  }
}