data "octopusdeploy_spaces" "spaces" {
    partial_name = "Default"
}

resource "octopusdeploy_space" "myspace" {
    description = "MySpace, get it!?"
    name = "MySpace"
    is_default = false
    is_task_queue_stopped = false
    space_managers_teams = ["teams-everyone"]
}

output "octopus_space_id" {
  value = octopusdeploy_space.myspace.id
}