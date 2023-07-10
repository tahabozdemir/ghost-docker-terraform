resource "aws_s3_bucket" "ghost_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "ghost_access" {
  bucket = aws_s3_bucket.ghost_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
}

