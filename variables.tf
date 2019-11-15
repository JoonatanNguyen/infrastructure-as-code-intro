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
  default     = "us-east-1"
}

variable "ec2_instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.small"
}

variable "ec2_server_port" {
  description = "HTTP port exposed on EC2 instance"
  default     = 80
}

variable "ec2_enable_cluster" {
  description = "Enable creation of cluster"
  default     = false
}

variable "vpc_cidr" {
  description = "CIDR for the main VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "private_subnet_cidrs" {
  description = "CIDR for private subnet"
  type        = list(string)
  default = [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ]
}
