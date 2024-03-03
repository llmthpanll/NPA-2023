##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "ASIAW3MEELGIRGBSAYNP"
  secret_key = "d1va7N5xNOz/wYMNDkL6iohDj6BOiEGd7wbyrXNV"
  token      = "FwoGZXIvYXdzED0aDDS984aaTULeOXOiDyLFAe98Ubyjj05YBNlRQNuH2zdoqEBw05j4BrvIDYOE9ECqcaZo1C7bdoqbniK6IzyieevdHROqzalix9Mh9He/b3d1atF8M2wfMm8ACc9UCGLxf9lccb0ETt/nEiScRQDTnYHho0FqwfkRU6+7gIxHSIyHIEFIXpalczfRj2Up7RRJbqy9WxmE78dYOvzThvtIcmAb0v08rpg63Qs9v5lw0hAEVOI3MJL+V2inhYuEIHZUMUZpN0RYoSxIQmBQrcW/xaykWga+KJyPha8GMi0/AooVThiCuKa3o0owYRqJXhHCRRGa5WVjjvZFqVQ6wy5PInWXxxN7T4VTZHU="
  region     = "us-east-1"
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

data "aws_instance" "EC2_list" {
  depends_on = [aws_instance.server1, aws_instance.Server2]
}


##################################################################################
# RESOURCES
##################################################################################

#This uses the default VPC.  It WILL NOT delete it on destroy.
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

resource "aws_route_table_association" "PublicRouteTableAssociation" {
  subnet_id      = aws_subnet.Public1.id
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

resource "aws_instance" "server1" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = "vockey"
  subnet_id               = aws_subnet.Public1.id
  vpc_security_group_ids = [aws_security_group.AllowSSHandWeb.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "server1"
  }
}

resource "aws_instance" "Server2" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = "vockey"
  subnet_id               = aws_subnet.Public1.id
  vpc_security_group_ids = [aws_security_group.AllowSSHandWeb.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }
  tags = {
    Name = "Server2"
  }
}

# resource "aws_lb_target_group" "EC2TargetGroup" {
#   name     = "EC2TargetGroup"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.testVPC.id
#   target_type = "instance"
# }

# resource "aws_lb_target_group_attachment" "test" {
#   count = length(data.aws_instance.EC2_list.id)
#   target_group_arn = aws_lb_target_group.EC2TargetGroup.arn
#   target_id        = data.aws_instance.EC2_list.id[count.index]
#   port             = 80
# }


# resource "aws_lb" "elb-webLB" {
#   name               = "elb-webLB"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.AllowSSHandWeb.id]
#   subnets            = [aws_subnet.Public1.id]

#   enable_deletion_protection = true

#   tags = {
#     Environment = "production"
#   }
# }

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = aws_instance.server1.public_dns
}

output "aws_instance_public_ip" {
  value = aws_instance.server1.public_ip
}