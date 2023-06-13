resource "aws_s3_bucket" "www" {
  bucket        = "www.${var.domain_name}"
  force_destroy = true
}
resource "aws_s3_bucket" "root" {
  bucket        = var.domain_name
  force_destroy = true
}
resource "aws_s3_bucket" "logs" {
  bucket        = "logs.${var.domain_name}"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "logs" {
  bucket = aws_s3_bucket.logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

locals {
  bucket_ids = {
    www  = aws_s3_bucket.www.id
    root = aws_s3_bucket.root.id
  }

  bucket_policies = {
    www  = templatefile("${path.module}/files/s3-policy.json", { bucket = "www.${var.domain_name}"})
    root = templatefile("${path.module}/files/s3-policy.json", { bucket = "${var.domain_name}"})
  }
}
resource "aws_s3_bucket_ownership_controls" "website" {
  for_each = local.bucket_ids
  bucket   = each.value
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "website_allow_access" {
  for_each = local.bucket_ids
  bucket   = each.value

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

  depends_on = [aws_s3_bucket.root, aws_s3_bucket.www, aws_s3_bucket.logs]

}

resource "aws_s3_bucket_policy" "website" {
  for_each = local.bucket_ids
  bucket   = each.value

  policy     = local.bucket_policies[each.key]
  depends_on = [aws_s3_bucket_acl.website]
}
resource "aws_s3_bucket_acl" "website" {
  for_each   = local.bucket_ids
  bucket     = each.value
  acl        = "public-read"
  depends_on = [aws_s3_bucket_public_access_block.website_allow_access]
}

resource "aws_s3_bucket_cors_configuration" "website" {
  bucket = aws_s3_bucket.www.id
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://www.${var.domain_name}"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_website_configuration" "root" {
  bucket = aws_s3_bucket.root.id
  redirect_all_requests_to {
    host_name = aws_s3_bucket_website_configuration.www.website_endpoint
  }
}
resource "aws_s3_bucket_website_configuration" "logs" {
  bucket = aws_s3_bucket.logs.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

module "template_files" {
  version = "1.0.2"
  source   = "hashicorp/dir/template"
  base_dir = var.static_website_directory
}

resource "aws_s3_object" "website_files" {
  for_each     = module.template_files.files
  bucket       = aws_s3_bucket.www.id
  key          = each.key
  content_type = each.value.content_type
  source       = each.value.source_path
  content      = each.value.content
  etag         = each.value.digests.md5
}

resource "aws_s3_bucket_logging" "logs_logging" {
  bucket = aws_s3_bucket.logs.id

  target_bucket = aws_s3_bucket.logs.id
  target_prefix = "logs/"
}
