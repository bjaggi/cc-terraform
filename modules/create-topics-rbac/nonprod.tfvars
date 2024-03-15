# CC Keys for creating resources 

#Confluent Cluster Keys used to create the cluster
confluent_cloud_api_key="GAYWHUFZZZNYDJ7D"
confluent_cloud_api_secret="/QFOJ5FNGXEUsH6JFCts6uLgDr05vtr9glBQD7nLFH95aKI+mFS0N+IS0f6MU9BP"




# Kafka key to access kafka resources "sa-036329"
admin_sa = {
   id="VT72ZYEPJIMFY3MJ"
   secret="1SFwlfZGr9KlE+r8iYq5/V7ThO5jvrc5YdLfAdPeHUP1U3ebVGfYE1/T3ID30HKR"
}
confluent_cloud_cluster_id= "lkc-y316j"
confluent_cloud_env_id="env-7qv2p"

#CLuster Environment details




consumer_sa_name="XXXXX"
producer_sa_name="XXXXX"

topics = [ 
   {
   name       = "topic-a"
   partitions = 4
   config = { 
     "delete.retention.ms"                     = "86100000" 
   }
  },
  {
   name = "topic-b"
   partitions = 3
   config = {
    "delete.retention.ms" = "10000000"
   }
  }
]

