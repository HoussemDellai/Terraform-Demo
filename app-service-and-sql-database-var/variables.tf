##  variable random {}

##  variable password {}

variable "prefix" {
  default     = "test"
  description = "The prefix used for all resources in this example"
}

variable "app-service-name" {
  default     = "app-service"
  description = "The name of the Web App"
}

variable "location" {
  default     = "West US 2"
  description = "The Azure location where all resources in this example should be created"
}

variable "tags" {
  type = map
  default = {
    DeployedBy    = "Azure DevOps"
    ProvisionedBy = "terraform"
    Environment   = "testing"
  }
}
