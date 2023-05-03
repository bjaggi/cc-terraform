output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${data.confluent_environment.bell_env.id}

  
  EOT

  sensitive = true
}