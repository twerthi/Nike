resource "octopusdeploy_library_variable_set" "myvariableset2" {
    name = "My Variable Set2"
    description = "Testing"
    space_id = var.octopus_space_id
}

resource "octopusdeploy_variable" "firstname_production" {
    name = "MySet.Variable1"
    type = "String"
    is_editable = true
    is_sensitive = false
    value = "Value1"
    description = "Value 1 for Production"
    owner_id = octopusdeploy_library_variable_set.myvariableset2.id
    scope {
      environments = [octopusdeploy_environment.production.id]
      roles = ["Role1"]
    }
}

resource "octopusdeploy_variable" "firstname_development" {
    name = "MySet.Variable2"
    type = "String"
    is_editable = true
    is_sensitive = false
    value = "Value2"
    description = "Value 2 for Development"
    owner_id = octopusdeploy_library_variable_set.myvariableset2.id
    scope {
      environments = [octopusdeploy_environment.development.id]
      roles = ["Role1", "DifferentRole"]
    }
}