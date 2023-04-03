resource "aws_vpc_endpoint" "vpce_east" {
  vpc_id             = aws_vpc.vpc_east.id
  service_name       = mongodbatlas_privatelink_endpoint.pe_east.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  subnet_ids         = [aws_subnet.subnet_east_a.id]
  security_group_ids = [aws_security_group.sg_east.id]
}

resource "aws_vpc" "vpc_east" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "ig_east" {
  vpc_id = aws_vpc.vpc_east.id
}

resource "aws_route" "route_east" {
  route_table_id         = aws_vpc.vpc_east.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig_east.id
}

resource "aws_subnet" "subnet_east_a" {
  vpc_id                  = aws_vpc.vpc_east.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-central-1a"
}

resource "aws_security_group" "sg_east" {
  name_prefix = "default-"
  description = "Default security group for all instances in vpc"
  vpc_id      = aws_vpc.vpc_east.id
  ingress = [
    {
      description      = "All Ports/Protocols"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
  egress = [
    {
      description      = "All Ports/Protocols"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]
}

data "aws_ami" "AWSlinux2" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-2.0.20210721.2-x86_64-gp2"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.AWSlinux2.id
  instance_type          = var.aws_instance
  vpc_security_group_ids = [aws_security_group.sg_east.id]
  key_name               = var.key_name

  subnet_id = aws_subnet.subnet_east_a.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 20
  }

  user_data = file("${path.module}/user_data.sh")
}
