resource "aws_s3_bucket" "bucket-rafi-nlr3" {
  bucket = "bucket-rafi-nlr3"
  acl    = "private"

  tags = {
    Name        = "bucket-rafi-nlr3"
    Environment = "Dev"
  }
}