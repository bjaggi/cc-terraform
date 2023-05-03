variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (also referred as Cloud API ID)"
  type        = string
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret"
  type        = string
  sensitive   = true
}


variable "confluent_cloud_env_id" {
  description = "Confluent Cloud Environment "
  type        = string
  sensitive   = false
}

variable "confluent_cloud_cluster_id" {
  description = "Confluent Cloud Cluster  "
  type        = string
  sensitive   = false
}


variable "cluster_cloud" {
  description = "Confluent Cloud Cloud Provider "
  type        = string
  sensitive   = false
}

variable "customer_project_id" {
  description = "Confluent Cloud Project Id "
  type        = string
  sensitive   = false
}

    variable "cluster_display_name" {
  description = "Confluent Cloud name "
  type        = string
  sensitive   = false
}
    variable "cluster_availability" {
  description = "Confluent Cloud availability "
  type        = string
  sensitive   = false
}


variable "cluster_subnet_name_by_zone" {
  description = "A map of Zone to Subnet Name"
  type        = map(string)
}

    variable "cluster_region" {
  description = "Confluent Cloud region "
  type        = string
  sensitive   = false
}
    variable "cluster_type" {
  description = "Confluent Cloud type "
  type        = string
  sensitive   = false
}
    variable "cluster_cku" {
  description = "Confluent Cloud cku "
  type        = string
  sensitive   = false
}
     


variable "customer_vpc_network" {
  description = "The VPC network name to provision Private Service Connect endpoint to Confluent Cloud"
  type        = string
}

variable "customer_subnetwork_name" {
  description = "The subnetwork name to provision Private Service Connect endpoint to Confluent Cloud"
  type        = string
}

variable "subnet_name_by_zone" {
  description = "A map of Zone to Subnet Name"
  type        = map(string)
}