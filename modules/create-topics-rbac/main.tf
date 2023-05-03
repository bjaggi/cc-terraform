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


provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}




data "confluent_environment" "bell_env" {
  id = var.confluent_cloud_env_id
}



# data "confluent_kafka_cluster" "bell_cluster" {
#   id = var.confluent_cloud_cluster_id
#   environment {
#     id = var.confluent_cloud_env_id
#   }
# }


resource "confluent_kafka_cluster" "bell_cluster" {
  display_name = var.cluster_display_name
  availability = "SINGLE_ZONE"
  cloud        = var.cluster_cloud
  region       = var.cluster_region
  standard {
  
  }
  environment {
    id = data.confluent_environment.bell_env.id
  }

    lifecycle {
    prevent_destroy = true
  }

}

resource "confluent_service_account" "app-manager" {
  display_name = "bell-sa-manager"
  description  = "Service account to manage 'inventory' Kafka cluster"
}


resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.bell_cluster.rbac_crn
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.bell_cluster.id
    api_version = confluent_kafka_cluster.bell_cluster.api_version
    kind        = confluent_kafka_cluster.bell_cluster.kind

    environment {
      id = data.confluent_environment.bell_env.id
    }
  }

  # The goal is to ensure that confluent_role_binding.app-manager-kafka-cluster-admin is created before
  # confluent_api_key.app-manager-kafka-api-key is used to create instances of
  # confluent_kafka_topic, confluent_kafka_acl resources.

  # 'depends_on' meta-argument is specified in confluent_api_key.app-manager-kafka-api-key to avoid having
  # multiple copies of this definition in the configuration which would happen if we specify it in
  # confluent_kafka_topic, confluent_kafka_acl resources instead.
  depends_on = [
    confluent_role_binding.app-manager-kafka-cluster-admin
  ]
}


resource "confluent_kafka_topic" "bell_topic" {
  kafka_cluster {
    id = confluent_kafka_cluster.bell_cluster.id
  }
  topic_name         = "bell_first_topic"
  rest_endpoint      = confluent_kafka_cluster.bell_cluster.rest_endpoint
credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }
}

# RBAC  for bell_topic


resource "confluent_kafka_topic" "bell_topic-2" {
  kafka_cluster {
    id = confluent_kafka_cluster.bell_cluster.id
  }
  topic_name         = "bell_second_topic"
  rest_endpoint      = confluent_kafka_cluster.bell_cluster.rest_endpoint
credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }
}

# RBAC  for bell_topic2 

