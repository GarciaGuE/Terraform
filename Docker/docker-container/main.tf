terraform {
	# Specifying the required providers
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# Definition of the provider and specification of the host where it is located
provider "docker" {
  host    = "unix:///var/run/docker.sock"
}

# Defining the resource (Docker image) and setting "nginx" as the name of the image
resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false # Eliminates the image from the local cache
}

# Definición del recurso (contenedor de Docker), utilizando la imagen definida
# como base para el contendor, además de nombrarlo como "tutorial"

# Definiton of the resource (Docker container), using the image defined as the base for the container and naming it "tutorial"
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "tutorial"
	
  # Setting up the listening ports (80) and the mapping of 80 (8000)
  ports {
    internal = 80
    external = 8000
  }
}