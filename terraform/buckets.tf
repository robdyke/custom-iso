resource "aws_s3_bucket" "builds_bucket" {
  bucket = "iso-builds"
  acl    = "public-read"
}
