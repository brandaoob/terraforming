resource "aws_s3_bucket" "terraforming-bucket" {
  for_each = toset(var.buckets)
  bucket   = "terraforming-capuccino-${each.value}"
  tags = {
    Name = upper(each.value) // should have type of stuff stored
  }
}

resource "aws_s3_bucket_ownership_controls" "terraforming-bucket-ownership" {
  for_each = toset(var.buckets)
  bucket   = aws_s3_bucket.terraforming-bucket[each.key].id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "terraforming-bucket-acl" { // private bucket
  for_each   = toset(var.buckets)
  depends_on = [aws_s3_bucket_ownership_controls.terraforming-bucket-ownership]
  bucket     = aws_s3_bucket.terraforming-bucket[each.key].id
  acl        = "private"
}