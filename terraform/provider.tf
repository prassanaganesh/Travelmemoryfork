provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "TravelMemory"
      ManagedBy   = "Terraform"
      Environment = "Assignment"
    }
  }
}
