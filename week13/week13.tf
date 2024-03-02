##################################################################################
# variable
##################################################################################

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_session_token" {}
variable "default_region" {}
variable "key_name" {}

##################################################################################
# locals
##################################################################################

locals {
  common_tags = {
    Name = "itkmitl-npa2024"
  }

  itkmitl_tags = {
    Owner = "itkmitl"
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

# data "aws_instance" "EC2_list" {
#   depends_on = [aws_instance.Server1, aws_instance.Server2]
# }

##################################################################################
# RESOURCES
##################################################################################

resource "aws_vpc" "testVPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "testVPC"
  }
}

resource "aws_internet_gateway" "testIGW" {
  vpc_id = aws_vpc.testVPC.id
  tags = {
    Name = "testIGW"
  }
}

resource "aws_subnet" "Public1" {
  vpc_id     = aws_vpc.testVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.testIGW]
  tags = {
    Name = "Public1"
  }
}

resource "aws_subnet" "Public2" {
  vpc_id     = aws_vpc.testVPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  map_public_ip_on_launch = true
  depends_on = [aws_internet_gateway.testIGW]
  tags = {
    Name = "Public2"
  }
}

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.testVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testIGW.id
  }
  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "Public1RouteTableAssociation" {
  subnet_id      = aws_subnet.Public1.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_route_table_association" "Public2RouteTableAssociation" {
  subnet_id      = aws_subnet.Public2.id
  route_table_id = aws_route_table.PublicRouteTable.id
}

resource "aws_security_group" "AllowSSHandWeb" {
  name        = "AllowSSHandWeb"
  description = "Allow incoming SSH and HTTP traffic to EC2 Instance"
  vpc_id      = aws_vpc.testVPC.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = 6
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = 6
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "AllowSSHandWeb"
  }
}

resource "aws_instance" "Server1" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.Public1.id
  vpc_security_group_ids = [aws_security_group.AllowSSHandWeb.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "Server1"
  }
}

resource "aws_instance" "Server2" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.Public1.id
  vpc_security_group_ids = [aws_security_group.AllowSSHandWeb.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  # tags = local.common_tags
  tags = {
    Name = "Server2"
  }
}

resource "aws_lb" "elb-webLB" {
  name               = "elb-webLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.AllowSSHandWeb.id]
  subnets            = [aws_subnet.Public1.id, aws_subnet.Public2.id]
  enable_deletion_protection = false
  tags = {
    Name = "elb-webLB"
    Environment = "production"
  }
}

resource "aws_lb_target_group" "EC2TargetGroup" {
  name     = "EC2TargetGroup"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.testVPC.id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}

resource "aws_lb_target_group_attachment" "lb-attachment1" {
  target_group_arn = aws_lb_target_group.EC2TargetGroup.arn
  target_id        = aws_instance.Server1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "lb-attachment2" {
  target_group_arn = aws_lb_target_group.EC2TargetGroup.arn
  target_id        = aws_instance.Server2.id
  port             = 80
}

# Listener rule for HTTP traffic on each of the ALBs
resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn    = aws_lb.elb-webLB.arn
  port                 = "80"
  protocol             = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.EC2TargetGroup.arn
    type             = "forward"
  }
}

##################################################################################
# OUTPUT
##################################################################################

# output "aws_instance_public_dns" {
#   value = aws_instance.Server1.public_dns
# }

# output "aws_instance_public_ip" {
#   value = aws_instance.Server1.public_ip
# }