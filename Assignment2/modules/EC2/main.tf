resource "aws_instance" "this_instance" {
  ami                         = var.aws_instance.ami
  instance_type               = var.aws_instance.instance_type
  subnet_id                   = var.public_subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = var.aws_instance.associate_public_ip_address
  security_groups             = var.security_groups
  iam_instance_profile = var.iam_profile

  tags = {
    Name = var.aws_instance_name
  }
}