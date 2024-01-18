

### To Run the terraform script do the following steps.


. go to the respective module ( eg : `cd modules/create-topics`)  
. validate the contents of `nonprod.tfvars`   
.  ```terraform init```   
. ```terraform plan```   *IMP : Please Validate the plan*.   
. ```terraform apply --var-file nonprod.tfvars```


### Also try this
https://github.com/mcolomerc/ccloud-demo-tf/tree/main    
https://github.com/mcolomerc/terraform-confluent-topics/blob/main/main.tf#L50   
https://github.com/mcolomerc/terraform-confluent-sentinel-sample/blob/main/env/topics.tfvars    






