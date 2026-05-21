output "vpc_id" {

  description = "VPC ID"

  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {

  description = "Public Subnet ID"

  value = aws_subnet.public_subnet.id
}

output "security_group_id" {

  description = "Security Group ID"

  value = aws_security_group.web_sg.id
}

output "ec2_public_ip" {

  description = "EC2 Public IP"

  value = aws_instance.web_server.public_ip
}
