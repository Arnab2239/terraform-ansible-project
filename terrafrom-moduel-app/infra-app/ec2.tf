resource "aws_key_pair" "my-key" {
  key_name   = "${var.env}-infra-app-key"
  public_key = file("pubkeyy.pub")
  tags = {
    Environment = var.env
  }
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "my_group" {
  name        = "${var.env}-infra-app-sg_v2"
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
    Name = "${var.env}-infra-app-sg_v2"
  }
}


resource "aws_instance" "terra-ec2" {
  count = var.instance_count

  key_name               = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [aws_security_group.my_group.id]
  instance_type          = var.instance_type
  ami                    = var.ec2_ami_id
  

  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-arnab-infra-app-ec2-${count.index}"
    Environment = var.env
  }
}