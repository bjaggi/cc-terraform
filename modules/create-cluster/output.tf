output "resource-ids" {
  value = <<-EOT
  Following Recources were created: 
  Environment ID:   ${confluent_environment.customer_env.id}
  Cluster ID :  ${confluent_kafka_cluster.customer_cluster.id}
  
  
  EOT

  sensitive = true
}