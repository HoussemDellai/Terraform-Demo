variable "prefix" {
  default = "terraform"
  description = "The prefix used for all resources in this example"
}

variable "app-service-name" {
  default = "terraform-app-service"
  description = "The name of the Web App"
}

variable "location" {
  default = "West US 2"
  description = "The Azure location where all resources in this example should be created"
}
