output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${data.confluent_environment.bell_env.id}
  Confluent Cluster ID :  ${ confluent_kafka_cluster.bell_cluster.id}
  Bell First Topic : ${confluent_kafka_topic.bell_topic.config}
  
  EOT

}