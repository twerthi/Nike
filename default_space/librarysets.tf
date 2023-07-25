resource "octopusdeploy_library_variable_set" "myvariableset" {
    name = "My Variable Set"
    description = "Testing"
    space_id = var.octopus_space_id
}

resource "octopusdeploy_variable" "firstname_production" {
    name = "MySet.Name.First"
    type = "String"
    is_editable = true
    is_sensitive = false
    value = "MyFirstName"
    description = "Firstname Production"
    owner_id = octopusdeploy_library_variable_set.myvariableset.id
    scope {
      environments = [octopusdeploy_environment.production.id]
      roles = ["Role1"]
    }
}

resource "octopusdeploy_variable" "firstname_development" {
    name = "MySet.Name.First"
    type = "String"
    is_editable = true
    is_sensitive = false
    value = "MyFirstName"
    description = "Firstname Development"
    owner_id = octopusdeploy_library_variable_set.myvariableset.id
    scope {
      environments = [octopusdeploy_environment.development.id]
      roles = ["Role1", "DifferentRole"]
    }
}