resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "infra_bucket" {
  bucket = "${var.env}-infra-app-bucket-${random_id.suffix.hex}"

  tags = {
    Name        = "infra-bucket"
    Environment = var.env
  }
}
#call
