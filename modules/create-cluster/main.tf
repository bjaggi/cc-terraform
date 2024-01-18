
# Confluent keys used
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Create the current environment 
resource "confluent_environment" "customer_env" {
  display_name= var.confluent_cloud_env_name
}


resource "confluent_kafka_cluster" "customer_cluster" {
  display_name = var.cluster_display_name
  availability = var.cluster_availability
  cloud        = var.cluster_cloud
  region       = var.cluster_region
  dedicated {
    cku = var.cluster_cku
  }
  environment {
    id = resource.confluent_environment.customer_env.id
  }

  lifecycle {
    prevent_destroy = true
  }
}
