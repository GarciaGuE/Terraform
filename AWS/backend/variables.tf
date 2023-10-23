variable "bucket_name" {
  default = "backend-terraform-state-2023"
}
variable "acl" {
  default = "private"
}
variable "tags" {
  default = {
    Environment = "dev"
    CreatedBy   = "Emilio"
  }
}