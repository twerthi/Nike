module "space_creation" {
    source = "./space_creation"
    octopus_server = var.octopus_address
    octopus_apikey = var.octopus_api_key
    octopus_space_id = var.octopus_space_id
}

module "default_space" {
    source = "./default_space"
    octopus_apikey = var.octopus_api_key
    octopus_server = var.octopus_address
    octopus_space_id = var.octopus_space_id
}

module "my_space" {
    source = "./my_space"
    octopus_space_id = module.space_creation.octopus_space_id
    octopus_apikey = var.octopus_api_key
    octopus_server = var.octopus_address
}