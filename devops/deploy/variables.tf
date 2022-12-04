variable "prefix" {
  default = "blog"
}

variable "project" {
  default = "backend-htmx"
}

variable "contact" {
  default = "ij@gmail.com"
}

variable "ecr_image_api" {
  description = "ECR Image for API"
  default     = "544551787874.dkr.ecr.ap-south-1.amazonaws.com/backend-api-devops:latest"
}

variable "ecr_image_proxy" {
  description = "ECR Image for Proxy"
  default     = "544551787874.dkr.ecr.ap-south-1.amazonaws.com/backend-api-devops-proxy:latest"
}

variable "django_secret_key" {
  description = "Secret key for Django app"
  default = "asdf-secured-asdflkjsaldfjlaskjdflkjasldfkjlaksjdflkjlasjflklasjflkfjkslak"
}
