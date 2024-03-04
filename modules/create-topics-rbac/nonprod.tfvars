#Confluent CLoud Keys used to create the cluster
confluent_cloud_api_key="XXXXX"
confluent_cloud_api_secret = "XXXXXX"

#CLuster Environment details
confluent_cloud_env_name="Applied_NonProd-standard"

# Cluster details
cluster_display_name="Applied_NonProd"
cluster_cloud="AZURE"
cluster_availability="MULTI_ZONE"
cluster_region="eastus2"
cluster_cku="2"
cluster_type="standard"


topics = {
   {
    name=topic-a,
    partitions=1
  },
  {
    name=topic-2,
    partitions=2
  }
}

