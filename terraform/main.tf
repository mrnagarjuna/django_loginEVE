resource "aws_instance" "django_server" {

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name

  vpc_security_group_ids = [
    aws_security_group.django_sg.id
  ]

  associate_public_ip_address = true

  tags = {
    Name = "event-server"
  }
}