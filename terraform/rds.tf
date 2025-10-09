/*
1. rds tf resource
2. new security group
    - 3306security-grp => tf_ec2_sg
    - cidr_block => ["local ip"]
3. outputs
*/

#  rds resource
resource "aws_db_instance" "tf_rds_instance" {
  allocated_storage    = 10
  db_name              = "kunal_demo"
  identifier           = "nodejs-rds-mysql"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible = true
  vpc_security_group_ids = [ aws_security_group.tf_rds_sg.id ]
}
 
 resource "aws_security_group" "tf_rds_sg" {
vpc_id      = var.vpc_id
  name        = "allow_mysql"
  description = "Allow MySQL traffic"
  

  ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = [var.my_ip]
        security_groups = [aws_security_group.tf_ec2_sg.id] # allow from EC@ SG
    }

    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
 }

#  locals
locals {
    rds_endpoint = element(split(":", aws_db_instance.tf_rds_instance.endpoint), 0)
}

# output
output "rds_endpoint" {
  value = local.rds_endpoint
}

output "rds_username" {
  value = aws_db_instance.tf_rds_instance.username
}

output "db_name" {
  value = aws_db_instance.tf_rds_instance.db_name
}
