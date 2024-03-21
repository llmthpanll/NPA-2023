##################################################################################
# variable
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
variable "default_region" {}
variable "cidr_block" {
  default = "10.0.0.0/16"
}
variable "az" {
  default = ["us-east-1a", "us-east-1b"]
}
variable "Public_subnet_cidr" {
  type = map(any)
  default = {
    "Public1" = {
      "cidr_block" = "10.0.0.0/24"
      "availability_zone" = "us-east-1a"
      "subnet_name"       = "Public1"
    }
    "Public2" = {
      "cidr_block" = "10.0.1.0/24"
      "availability_zone" = "us-east-1b"
      "subnet_name"       = "Public2"
    }
  } 
}
variable "key_name" {}
variable "private_key" {}
variable "default_name" {
  default     = "itkmitl"
}

variable "EC2_list" {
  type = map(any)
  default = {
    "Server1" = {
      "instance_type" = "t2.micro"
      "ami"           = "ami-0c55b159cbfafe1f0"
      "subnet_id"     = "subnet-0bb1c79de3EXAMPLE"
    }
    "Server2" = {
      "instance_type" = "t2.micro"
      "ami"           = "ami-0c55b159cbfafe1f0"
      "subnet_id"     = "subnet-0bb1c79de3EXAMPLE"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

##################################################################################
# PROVIDERS
##################################################################################
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_session_token
  region     = var.default_region
}

##################################################################################
# DATA
##################################################################################

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}