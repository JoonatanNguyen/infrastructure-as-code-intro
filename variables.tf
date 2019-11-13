variable "company" {
  description = "Name of the company"
  default     = "Integrify"
}

variable "project" {
  description = "Name of the project"
  default     = "iac-intro"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "ec2_instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}

variable "ec2_server_port" {
  description = "HTTP port exposed on EC2 instance"
  default     = 80
}

variable "ec2_enable_cluster" {
  description = "Enable creation of cluster"
  default     = false
}
