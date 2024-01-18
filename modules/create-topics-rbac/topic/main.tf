data "confluent_kafka_cluster" "kafka_cluster" {
  id = var.cluster
  environment {
    id = var.environment
  }
}
 
resource "confluent_kafka_topic" "topic" { 
  kafka_cluster {
    id = data.confluent_kafka_cluster.kafka_cluster.id
  }
  topic_name    = var.topic.name
  partitions_count   = var.topic.partitions
  rest_endpoint = data.confluent_kafka_cluster.kafka_cluster.rest_endpoint
  credentials {
    key    = var.admin_sa.id
    secret = var.admin_sa.secret
  }
  config = var.topic.config

  # It is recommended to set lifecycle { prevent_destroy = true } on production instances to prevent accidental topic deletion. 
  # This setting rejects plans that would destroy or recreate the topic, such as attempting to change uneditable attributes (for example, partitions_count).
  lifecycle {
    prevent_destroy = true
  }
}

# RBAC  
data "confluent_service_account" "openai_applied_producer_sa" {
  display_name = var.producer_sa_name
}

data "confluent_service_account" "openai_applied_consumer_sa" {
  display_name = var.consumer_sa_name
}

## Role binding for the Kafka cluster 
resource "confluent_role_binding" "openai-applied-developer-read" {
  principal   = "User:${data.confluent_service_account.openai_applied_consumer_sa.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${data.confluent_kafka_cluster.kafka_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.kafka_cluster.id}/topic=${confluent_kafka_topic.topic.topic_name}"
  depends_on = [
    data.confluent_service_account.openai_applied_consumer_sa,
    data.confluent_service_account.openai_applied_producer_sa,
    data.confluent_kafka_cluster.kafka_cluster,
    confluent_kafka_topic.topic
  ]
}

resource "confluent_role_binding" "openai-applied-developer-write" {
  principal   = "User:${data.confluent_service_account.openai_applied_producer_sa.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${data.confluent_kafka_cluster.kafka_cluster.rbac_crn}/kafka=${data.confluent_kafka_cluster.kafka_cluster.id}/topic=${confluent_kafka_topic.topic.topic_name}"
  depends_on = [
    data.confluent_service_account.openai_applied_producer_sa,
    data.confluent_service_account.openai_applied_consumer_sa,
    data.confluent_kafka_cluster.kafka_cluster,
    confluent_kafka_topic.topic
  ]
}