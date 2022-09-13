resource "aws_s3_bucket" "bucket-rafi-nlr" {
  bucket = "bucket-rafi-nlr"
  acl    = "private"

  tags = {
    Name        = "bucket-rafi-nlr"
    Environment = "Dev"
  }
}