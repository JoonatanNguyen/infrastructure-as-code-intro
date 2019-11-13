resource "aws_key_pair" "this" {
  key_name   = "${var.project}-default"
  public_key = file("${path.module}/instance-public.key")
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu-18_04.id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.this.key_name

  vpc_security_group_ids = [
    aws_security_group.webserver.id
  ]

  associate_public_ip_address = true

  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.project}-webserver"
      "OS"   = "Ubuntu Linux"
    },
  )

  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/instance-private.key")
  }
}

output "instance_ip_addr" {
	description = "Public IP of the Web server"
	value = aws_instance.webserver.public_ip
}
