terraform {
  backend "s3" {
    # Add the three first and initialize with terraform init
    bucket = "backend-terraform-state-2023"
    key    = "state-s3"
    region = "eu-west-1"
    encrypt = true
    kms_key_id = "" # Add the key id, visible in the AWS console after creating the key (terraform apply)
  }
}