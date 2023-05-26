resource "aws_s3_bucket" "tfstate" {
  bucket = "nc-cloud-project-bucket"
  force_destroy = true

  tags = {
    Name        = "Terraform bucket"
    ManagedBy = "Terraform"
  }


}

resource "aws_s3_bucket_ownership_controls" "bucket-oc" {
  bucket = aws_s3_bucket.tfstate.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.bucket-oc]

  bucket = aws_s3_bucket.tfstate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "statetf-versioning" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "basic-dynamodb-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = "30"
  write_capacity = "30"
  attribute {
    name = "LockID"
    type = "S"
  }
  hash_key       = "LockID"
}