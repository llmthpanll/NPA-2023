##################################################################################
# RESOURCES
##################################################################################
resource "aws_instance" "Server" {
  count = length(var.Public_subnet_cidr)
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.Public[count.index].id
  vpc_security_group_ids = [aws_security_group.AllowSSHandWeb.id]

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install nginx -y",
      "sudo service nginx start",
      "sudo rm /usr/share/nginx/html/index.html",
      "echo '<html><head><title>Blue Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">Blue Team</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html"
    ]
  }

  tags = merge(local.default_tags,{Name = "${var.default_name}-Server${count.index + 1}"})
}
