resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "arnab-state-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"
  

  attribute {
    name = "LockID"
    type = "S"
  }

  

  tags = {
    Name        = "arnab-state-table"
    Environment = "production"
  }
}