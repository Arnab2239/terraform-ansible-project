resource "aws_s3_bucket" "my_bucket" {
  bucket = "arnab-lock-bucket"

  tags = {
    Name        = "arnab-lock-bucket"
    Environment = "Dev"
  }
}