# Confluent keys used
provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

data "confluent_environment" "openai_env" {
  id = var.confluent_cloud_env_id
}

data "confluent_kafka_cluster" "openai_cluster" {
  id = var.confluent_cloud_cluster_id
  environment {
    id = var.confluent_cloud_env_id
  }
}



# RBAC  
resource "confluent_service_account" "openai_applied_producer_sa" {
  display_name = var.producer_sa_name
}

resource "confluent_service_account" "openai_applied_consumer_sa" {
  display_name = var.consumer_sa_name
}



module "topic" {
  for_each        = { for topic in var.topics : topic.name => topic }
  source          = "./topic"
  environment     = data.confluent_environment.openai_env.id
  cluster         = data.confluent_kafka_cluster.openai_cluster.id
  topic           = each.value
  
  admin_sa        = {
    id = var.admin_sa.id
    secret = var.admin_sa.secret
  }
  rbac_enabled    = var.rbac_enabled
  producer_sa_name = var.producer_sa_name
  consumer_sa_name = var.consumer_sa_name

  depends_on = [ confluent_service_account.openai_applied_consumer_sa , confluent_service_account.openai_applied_producer_sa ]

}





