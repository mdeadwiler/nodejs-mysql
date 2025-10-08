/* 
1. ec2 instance resource
2. new security group
    - 22 (ssh)
    - 443 (https)
    - 3000 (nodejs) // ip:3000
*/

resource "aws_instance" "tf_ec2_instance" {
  ami           = "ami-0360c520857e3138f" # Ubuntu image
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  tags = {
    Name = "HelloWorld"
  }
}