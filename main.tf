provider "aws" {
  alias  = "primary"
  region = var.primary_region
  secret_key = ""
  access_key = ""
  
}

