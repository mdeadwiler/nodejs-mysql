resource "aws_s3_bucket" "tf_s3_bucket" {
  bucket = "nodejs-bkt-marquise-01"

  tags = {
    Name        = "Nodejs terraform bucket"
    Environment = "Dev"
  }
}