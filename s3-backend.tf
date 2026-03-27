terraform {
  backend "s3" {
    bucket       = "s3-backend-01"
    key          = "infra/terraform.tfstate"
    region       = "ap-south-1"
    encrypt      = true
    use_lockfile = true    # ✅ this uses S3 native locking, no DynamoDB needed
  }
}
