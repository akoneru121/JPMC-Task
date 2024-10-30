

provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
  secret_key = ""
  access_key = ""
}




