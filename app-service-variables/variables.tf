variable "resource-group-name" {
  default = "terraform-resource-group"
  description = "The prefix used for all resources in this example"
}

variable "location" {
  default = "West Europe"
  description = "The Azure location where all resources in this example should be created"
}