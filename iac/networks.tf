resource "docker_network" "frontend_backend" {
  name = "frontend-backend-${terraform.workspace}"
}
resource "docker_network" "backend_database" {
  name = "backend-database-${terraform.workspace}"
}