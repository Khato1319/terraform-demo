variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "us-east-1"
}


variable "static_website_directory" {
  description = "Static export directory of NextJS App"
  type        = string
  default     = "../frontend/out"
}


variable "domain_name" {
  description = "Domain name"
  type        = string
  default     = "examplewebsitefordemo.com"
}

