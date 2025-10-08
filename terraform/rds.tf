/*
1. rds tf resource
2. new security group
    - 3306security-grp => tf_ec2_sg
    - cidr_block => ["local ip"]
3. outputs
*/

#  rds resource
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "kunal_demo"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}
 