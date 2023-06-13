terraform {
  required_version = ">= 1.0.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4.0"
    }
  }
}



module "web_app_1" {
  source = "./web-app"

  # Input Variables
  region = var.region
  domain_name             = var.domain_name
  static_website_directory = var.static_website_directory
}
