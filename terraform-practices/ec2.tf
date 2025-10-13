resource "aws_key_pair" "my-key" {
  key_name   = "pubkeyy"
  public_key = file("pubkeyy.pub")
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "my_group" {
  name        = "automate-sg_v2"
  description = "this will be add"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "Allow SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "automate-sg-v2"
  }
}


resource "aws_instance" "terra-ec2" {
  count = 3

  key_name               = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [aws_security_group.my_group.id]
  instance_type          = var.ec2_instance_type
  ami                    = var.ec2_ami_id
  user_data              = file("install_nginx.sh")

  root_block_device {
    volume_size = var.ec2_root_storage_size
    volume_type = "gp3"
  }

  tags = {
    Name = "arnab-terra-${count.index}"
  }
}
