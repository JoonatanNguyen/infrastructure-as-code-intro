resource "aws_security_group" "webserver" {
  name = "${var.project}-instance"

  # Allow inbound HTTP from anywhere
  ingress {
    from_port   = var.ec2_server_port
    to_port     = var.ec2_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	# Uncomment to allow SSH access
	/*
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }*/

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-instance"
    }
  )
}
