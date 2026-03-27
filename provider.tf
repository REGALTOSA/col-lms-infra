terraform {
  required_version = ">= 1.0"        # ✅ add terraform version lock

  required_providers {
    aws = {                           # ✅ space before =
      source  = "hashicorp/aws"
      version = "~> 6.0"             # ✅ latest stable version
    }
  }

}

provider "aws" {
  region = var.aws_region            # ✅ use variable instead of hardcoded
}