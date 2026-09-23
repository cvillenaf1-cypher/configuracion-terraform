resource "docker_network" "fronted_backend" {
name= "fronted-backend-${terraform.workspace}"
}

resource "docker_network" "backend_database" {
  name = "backend-database-${terraform.workspace}"
}