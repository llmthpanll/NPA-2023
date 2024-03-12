##################################################################################
# RESOURCES
##################################################################################

resource "aws_vpc" "testVPC" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  # tags = local.default_tags
  tags = merge(local.default_tags,{Name = "${var.default_name}-testVPC"})
}

resource "aws_internet_gateway" "testIGW" {
  vpc_id = aws_vpc.testVPC.id
  tags = merge(local.default_tags,{Name = "${var.default_name}-testIGW"})
}

resource "aws_subnet" "Public" {
  for_each = var.Public_subnet_cidr
  vpc_id     = aws_vpc.testVPC.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch   = true
  depends_on = [aws_internet_gateway.testIGW]
  tags = merge(local.default_tags,{Name = "${var.default_name}-${each.value.subnet_name}"})
}

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.testVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testIGW.id
  }
  tags = merge(local.default_tags,{Name = "${var.default_name}-PublicRouteTable"})
}

resource "aws_route_table_association" "Public1RouteTableAssociation" {
  count = length(var.Public_subnet_cidr)
  subnet_id      = aws_subnet.Public["Public${count.index + 1}"].id
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
  tags = merge(local.default_tags,{Name = "${var.default_name}-AllowSSHandWeb"})
}