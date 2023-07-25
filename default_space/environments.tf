resource "octopusdeploy_environment" "development" {
    allow_dynamic_infrastructure = true
    description = "Development environment"
    name = "Development"
    space_id = var.octopus_space_id
}

resource "octopusdeploy_environment" "test" {
    allow_dynamic_infrastructure = true
    description = "Test environment"
    name = "Test"
    space_id = var.octopus_space_id
}

resource "octopusdeploy_environment" "production" {
    allow_dynamic_infrastructure = true
    description = "Production environment"
    name = "Production"
    space_id = var.octopus_space_id
}