/* 
1. ec2 instance resource
2. new security group
    - 22 (ssh)
    - 443 (https)
    - 3000 (nodejs) // ip:3000
*/

resource "aws_instance" "tf_ec2_instance" {
  ami           = "ami-0360c520857e3138f" # Ubuntu image
  instance_type = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.tf_ec2_sg.id]
  key_name = "terraform-ec2"
  
  tags = {
    Name = "Nodejs-server"
  }
}

# Security Group
resource "aws_security_group" "tf_ec2_sg" {
  name        = "nodejs-server-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = "vpc-0a55ff24d096fe43d"  # default VPC

  ingress {
        description = "Allow TLS from VPC"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # allow all IPs
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # For best practices I would normally use my IP address or a private IP address
    }

    ingress {
        description = "TCP"
        from_port = 3000 # for nodejs app
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
# Keep in mind as said earlier this isn't typcally best practices. This is for education purposes 
  tags = {
    Name = "Nodejs-server-sg"
  }
}

