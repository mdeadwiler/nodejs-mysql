variable "db_password" {
  description = "RDS database password"
  type        = string
  sensitive   = true
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
  default     = "my-key-pair"
}

variable "security_group_id" {
  description = "Security group ID"
  type        = string
  default     = "sg-0123456789abcdef0"
}

variable "subnet_id" {
  description = "Subnet ID"
  type        = string
  default     = "subnet-0123456789abcdef0"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "my_ip" {
  description = "Your local IP address for RDS access"
  type        = string
  sensitive   = true
}
