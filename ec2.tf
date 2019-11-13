resource "aws_key_pair" "this" {
  key_name   = "${var.project}-default"
  public_key = file("${path.module}/instance-public.key")
}

resource "aws_instance" "webserver" {
  ami           = data.aws_ami.ubuntu-18_04.id
  instance_type = var.ec2_instance_type
  key_name      = aws_key_pair.this.key_name
  subnet_id = aws_subnet.public[0].id

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
}

resource "null_resource" "provisioner" {
  connection {
    host        = aws_instance.webserver.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/instance-private.key")
  }

  provisioner "file" {
    source      = "provision/webserver"
    destination = "/home/ubuntu/"
  }

  provisioner "remote-exec" {
    script = "provision/server-init.sh"
  }
}

output "ec2_public_ip" {
  description = "Public IP of the Web server"
  value       = aws_instance.webserver.public_ip
}
