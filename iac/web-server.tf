resource "docker_image" "frontend" {
  name = "nginx:1.25-alpine"
}

resource "docker_image" "backend" {
  name = "node:20-alpine"
}

resource "docker_image" "database" {
  name = "postgres:16-alpine"
}

resource "docker_container" "frontend" {
  name  = "frontend-${terraform.workspace}"
  image = docker_image.frontend.image_id

  ports {
    internal = 80
    external = var.frontend_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.frontend_backend.name
  }
}


resource "docker_container" "backend" {
  name  = "backend-${terraform.workspace}"
  image = docker_image.backend.image_id

  ports {
    internal = 3000
    external = var.backend_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.frontend_backend.name
  }

  networks_advanced {
    name = docker_network.backend_database.name
  }
}


resource "docker_container" "database" {
  name  = "database-${terraform.workspace}"
  image = docker_image.database.image_id

  ports {
    internal = 5432
    external = var.database_port[terraform.workspace]
  }

  networks_advanced {
    name = docker_network.backend_database.name
  }

  env = [
    "POSTGRES_PASSWORD=postgres"
  ]
}