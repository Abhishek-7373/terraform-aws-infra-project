# AWS VPC and EC2 Instance Variables

variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "ap-south-1"
}

# VPC and Subnet Variables
variable "vpc_cidr" {

  description = "VPC CIDR Block"

  type = string

  default = "10.0.0.0/16"
}

# Public Subnet Variables
variable "public_subnet_cidr" {

  description = "Public Subnet CIDR"

  type = string

  default = "10.0.1.0/24"
}

# Private Subnet Variables
variable "availability_zone" {

  description = "AWS Availability Zone"

  type = string

  default = "ap-south-1a"
}

# EC2 Instance Variables
variable "instance_type" {

  description = "EC2 Instance Type"

  type = string

  default = "t2.micro"
}

# AWS Key Pair Variables
variable "key_name" {

  description = "AWS Key Pair Name"

  type = string

  default = "terraform-key"
}

# Allowed SSH IP Variable
variable "allowed_ssh_ip" {

  description = "Allowed SSH IP"

  type = string
}
