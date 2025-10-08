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
  depends_on = [ aws_s3_object.otf_s3_object ]
  #To run script as file("script.sh") from script file

  user_data = <<-EOF
    #!/bin/bash
    
    # Git clone
    git clone https://github.com/mdeadwiler/nodejs-mysql.git /home/ubuntu/nodejs-mysql
    cd /home/ubuntu/nodejs-mysql
    
    # Install nodejs
    sudo apt update -y
    sudo apt install -y nodejs npm
    
    # Edit env vars
    echo "DB_HOST=" | sudo tee -a .env
    echo "DB_USER=" | sudo tee -a .env
    echo "DB_PASS=" | sudo tee -a .env
    echo "DB_NAME=nodejs-mysql" | sudo tee -a .env
    echo "DB_Table_NAME=" | sudo tee -a .env
    echo "PORT=" | sudo tee -a .env
    
    # Start server
    npm install
    EOF

user_data_replace_on_change  = true
  tags = {
    Name = "Nodejs-server"
  }
}

# Security Group - This is just to show I am using a security group for the EC2 instance. However, I would create a more secured security group for production.
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
  tags = {
    Name = "Nodejs-server-sg"
  }
}

# output
output "ec2_public_ip" {
  value = "ssh -i ~/.ssh/terraform-ec2.pem ubuntu@${aws_instance.tf_ec2_instance.public_ip}"
}
