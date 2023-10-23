terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "backend" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.backend.id
  acl    = var.acl
  depends_on = [ aws_s3_bucket_ownership_controls.aws_s3_bucket_acl_ownership_controls]
}

# If you use ACLs, you must add the following resources
resource "aws_s3_bucket_ownership_controls" "aws_s3_bucket_acl_ownership_controls" {
  bucket = aws_s3_bucket.backend.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_object" "files" {
  bucket = aws_s3_bucket.backend.id
  for_each = fileset("../backend", "*.tf")
  key = each.value
  #source = "../backend/main.tf"
  source = "../backend/${each.value}"
  etag = filemd5("../backend/${each.value}")
}


################## ENCRYPTED BUCKET ##################
resource "aws_kms_key" "mykey" {
  description             = "Terraform KMS key state file"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "server-side-encryption" {
  bucket = aws_s3_bucket.backend.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }  
}

# Print the ARN of the key to use in the backend.tf file
output "arn" {
  value = aws_kms_key.mykey.arn
}