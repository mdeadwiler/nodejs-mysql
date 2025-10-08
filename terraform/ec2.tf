/* 
1. ec2 instance resource
2. new security group
    - 22 (ssh)
    - 443 (https)
    - 3000 (nodejs) // ip:3000
*/

resource "aws_instance" "tf_ec2_instance" {
  ami           = "4"
  instance_type = "t3.micro"

  tags = {
    Name = "HelloWorld"
  }
}