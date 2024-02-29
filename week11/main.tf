##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  access_key = "ASIAW3MEELGI5MVNLOGD"
  secret_key = "T+GWA/PlRQrLplZhaTwsIpdLu0ATeYS8hvKcgRzQ"
  token      = "FwoGZXIvYXdzELP//////////wEaDMlRaGejaA8TR9Bm0yLFAVRA02jAG+Rs6QRVttlp38+QvJF+ts55UfDbTpuCGu1qi5sfJt6EmHrjdMuR5URISBQrX22pEKvqA9C3nlcC4Zs5N41ltFsvajNwQlQpjKPgzOb2+3p/IB+VebbLYbWx+nh/jbLDwVtlTIFr/t0VvcysOTUdoS8EsVqZan8ZBJQgnegAaiURWrhAY+XK2b88HE3Rk/YUtE5SdOiB8/uWTVG7hvBa8/QaVB2Bw8dYjJJPn1QZzVbe/rwIBV/fL9Q+bNeMuvP4KOfz5q4GMi0mQafa3P0luabzM1/Q4FmYnMY4Mh+h2rzmELS/5FaaPOkmY03mcSBEOYZGjME="
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


##################################################################################
# RESOURCES
##################################################################################

#This uses the default VPC.  It WILL NOT delete it on destroy.
resource "aws_vpc" "testVPC" {
  cidr_block = "10.0.0.0/16"

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

resource "aws_instance" "testweb" {
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
    Name = "testweb"
  }
}

resource "aws_eip" "bar" {
  domain = "vpc"

  instance                  = aws_instance.testweb.id
  associate_with_private_ip = aws_instance.testweb.private_ip
  depends_on                = [aws_internet_gateway.testIGW]
}

##################################################################################
# OUTPUT
##################################################################################

output "aws_instance_public_dns" {
  value = aws_instance.testweb.public_dns
}