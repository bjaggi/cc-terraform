output "resource-ids" {
  value = <<-EOT
  Following Topics and Rbac will be create on the listed cluster : 
  
  Environment ID:   ${data.confluent_environment.openai_env.id}
  Confluent Cluster ID :  ${ data.confluent_kafka_cluster.openai_cluster.id}
  
  EOT

}


output "topics" {
  value = {
    for k, t in module.topic : k => {
      id         = t.created_topic.id
      name       = t.created_topic.topic_name
      partitions = t.created_topic.partitions_count
      config     = t.created_topic.config
    }
  }
}
