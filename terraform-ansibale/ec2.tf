resource "aws_key_pair" "my-key" {
  key_name   = "${var.env}terra-ansibale-key"
  public_key = file("terra-ansibale-key.pub")
  tags = {
    name = var.env
  }
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "my_group" {
  name        = "${var.env}automate-sg-v2"
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
    Name = "${var.env}automate-sg-v2"
  }
}


resource "aws_instance" "terra-ec2" {
  for_each = tomap ({
    arnab-master = "ami-03aa99ddf5498ceb9"
    arnab-1st-server = "ami-03aa99ddf5498ceb9"
    arnab-2nd-server = "ami-0ccdd739f0fa3566c"
    arnab-3rd-server = "ami-0caa91d6b7bee0ed0"
  })
  depends_on = [ aws_security_group.my_group, aws_key_pair.my-key ]

  key_name               = aws_key_pair.my-key.key_name
  vpc_security_group_ids = [aws_security_group.my_group.id]
  instance_type          = "t2.micro"
  ami                    = each.value
 

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = var.env
  }
}