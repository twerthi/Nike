terraform {
  required_providers {
    octopusdeploy = {
      source = "OctopusDeployLabs/octopusdeploy"
      version = "0.12.4" # example: 0.7.62
    }
  }
}

provider "octopusdeploy" {
  # configuration options
  address    = var.octopus_server
  api_key    = var.octopus_apikey
  space_id   = var.octopus_space_id
}