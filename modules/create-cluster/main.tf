terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.18.0"
    }
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.39.0"
    }
  }
}

# This key will work for the entire org
# remove hardcoded values and replace with Git lab variables 
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}


# Import the current environment 
data "confluent_environment" "bell_env" {
  id = var.confluent_cloud_env_id
  
}


# State is stored in GCS Bucket
terraform {
 backend "gcs" {
   bucket  = "bkt-datapltf-npe-nane1-tfstate-common-01"
   prefix = "edp-kafka-deployment"
 }
}



resource "confluent_network" "private-service-connect" {
  display_name     = var.psc_display_name
  cloud            = var.cluster_cloud
  region           = var.cluster_region
  connection_types = ["PRIVATELINK"]
  zones            = keys(var.subnet_name_by_zone)
  environment {
    id = data.confluent_environment.bell_env.id
  }

  lifecycle {
    # prevent_destroy = var.resources_prevent_destroy
    prevent_destroy = true
  }

}

# Create a new dedicated cluster in a specific env  , prevent destroy = true
resource "confluent_kafka_cluster" "dedicated" {
  display_name = var.cluster_display_name
  availability = var.cluster_availability
  cloud        = var.cluster_cloud
  region       = var.cluster_region
  dedicated {
    cku = var.cluster_cku
  }
  environment {
    id = data.confluent_environment.bell_env.id
  }

  lifecycle {
    #prevent_destroy = var.resources_prevent_destroy
    prevent_destroy = true
  }


network {
    id = confluent_network.private-service-connect.id
    # id ="n-p2jml0"
  }


}




resource "confluent_private_link_access" "gcp" {
  display_name = "GCP Private Service Connect"
  gcp {
    project = var.customer_project_id
  }
  environment {
    id = data.confluent_environment.bell_env.id
  }
  network {
    id = confluent_network.private-service-connect.id
  }
}

