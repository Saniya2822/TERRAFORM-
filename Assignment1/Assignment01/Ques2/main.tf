resource "aws_key_pair" "aws_3" {
  key_name   = var.key_name
  public_key = file("/root/.ssh/id_rsa.pub")
}

resource "aws_instance" "AWS_INSTANCE" {
  ami                     = var.ami
  instance_type           = var.instance_type
}

resource "aws_eip" "lb" {
  instance = aws_instance.AWS_INSTANCE.id 
  domain   = var.domain
}