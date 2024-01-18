variable "confluent_cloud_env_id" {
  description = "Confluent Cloud Environment Id "
  type        = string
  sensitive   = false
}

variable "confluent_cloud_cluster_id" {
  description = "Confluent Cloud CLuster Id "
  type        = string
  sensitive   = false
}
# Service Account Credentials to create the topic ( requires a lower RBAC & a CLuster Key)

variable "confluent_cloud_api_key" {
  description = "topic rbac admin apikey "
  type        = string
  sensitive   = false
}

variable "confluent_cloud_api_secret" {
  description = "topic rbac admin apisecret "
  type        = string
  sensitive   = false
}

# Service Account Credentials to create the topic ( requires a lower RBAC)
variable "admin_sa" {
  type = object({
    id     = string
    secret = string
  })
}


# RBAC enabled */
variable "rbac_enabled" {
  description = "Enable RBAC. If true producer/consumer will be used to configure Role Bindings for the Topic"
  type = bool
  default = false
}

variable "producer_sa_name" {
  type = string
}

variable "consumer_sa_name" {
  type = string
}


# Topic definition list 
variable "topics" {
  type = list(object({
    name = string
    partitions = number
    config =  map(string)
    consumer = optional(string)
    producer = optional(string)
  }))
  description = "List of Topics. If RBAC enabled producer service account will be configured as DeveloperWrite and consumer will be configured as DeveloperRead."
}



