resource "aws_security_group" "webserver" {
  name        = "${var.project}-instance"
  description = "Allow traffict to and from web server"
  vpc_id      = aws_vpc.this.id

  # Allow inbound HTTP from anywhere
  ingress {
    from_port   = var.ec2_server_port
    to_port     = var.ec2_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Uncomment to allow SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-instance"
    }
  )
}

resource "aws_security_group" "loadbalancer" {
  name        = "${var.project}-loadbalancer"
  description = "Allow traffict to and from load balancer"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = var.ec2_server_port
    to_port     = var.ec2_server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-instance"
    }
  )
}
