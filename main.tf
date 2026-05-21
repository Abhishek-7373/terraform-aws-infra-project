# -------------------------
# Latest Ubuntu AMI
# -------------------------

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {
    name = "virtualization-type"

    values = ["hvm"]
  }
}

# -------------------------
# VPC
# -------------------------

resource "aws_vpc" "main_vpc" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "prod-vpc"
    }
  )
}

# -------------------------
# Public Subnet
# -------------------------

resource "aws_subnet" "public_subnet" {

  vpc_id = aws_vpc.main_vpc.id

  cidr_block = var.public_subnet_cidr

  availability_zone = var.availability_zone

  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "public-subnet"
    }
  )
}

# -------------------------
# Internet Gateway
# -------------------------

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main_vpc.id

  tags = merge(
    local.common_tags,
    {
      Name = "prod-igw"
    }
  )
}

# -------------------------
# Route Table
# -------------------------

resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "public-route-table"
    }
  )
}

# -------------------------
# Route Table Association
# -------------------------

resource "aws_route_table_association" "public_assoc" {

  subnet_id = aws_subnet.public_subnet.id

  route_table_id = aws_route_table.public_rt.id
}

# -------------------------
# Security Group
# -------------------------

resource "aws_security_group" "web_sg" {

  name = "web-security-group"

  description = "Allow SSH and HTTP"

  vpc_id = aws_vpc.main_vpc.id

  # -------------------------
  # SSH Access
  # -------------------------

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = [var.allowed_ssh_ip]
  }

  # -------------------------
  # HTTP Access
  # -------------------------

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  # -------------------------
  # Outbound Traffic
  # -------------------------

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "web-sg"
    }
  )
}

# -------------------------
# EC2 Instance
# -------------------------

resource "aws_instance" "web_server" {

  ami = data.aws_ami.ubuntu.id

  instance_type = var.instance_type

  subnet_id = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  tags = merge(
    local.common_tags,
    {
      Name = "terraform-web-server"
    }
  )
}

# -------------------------
# S3 Bucket For Terraform State
# -------------------------

resource "aws_s3_bucket" "terraform_state" {

  bucket = "abhishek-tfstate-2026-devops-lab"

  tags = merge(
    local.common_tags,
    {
      Name = "terraform-state-bucket"
    }
  )
}
