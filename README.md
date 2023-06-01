# Instructions for repositroy
This repository creates a production ready network that can deploy a wesbite onto a highly available server.
It features a load balancer to distribute traffic and is provisioned using an auto-scaling group, so if any instances fail, another will be deployed.
## Prerequisite 
Have AWS CLI and Terraform installed.<br>
Log into AWS through the terminal (can export credentials or use an SSO profile).<br>
Push your index.html file to a github repository.
## Instructrios for state creation
The state_creation directory utilises an S3 bucket and DynamoDb table to create a remote state for storing the terraform state remotely. **The remote state only needs to be provisioned once.** You can check if it has been provisioned by logging into AWS, going to S3 bucket, and seeing if there is a relevant bucket with the state file being stored inside. If it is not there it needs to be provisioned: <br>
cd into the state_creation directory<br>
run **terraform init**<br>
run **terraform apply**<br>
**The outputs of the S3 bucket name, DynamoDB table name and KMS key will be needed.**

# Instructions to deploy website
1. **Skip to the next step if the remote state had already been provisioned**
If you had to provision the remote state, go into **providers.tf** in **infrastructure** directoy.
In backed s3 (lines 9 -15), some details will need to be changed. Using the outputs from the state creation that has just been done, change the **bucket, kms_key_id and dynamodb_table values** to the corresponding outputs given from the previous terraform apply.
<br>
2. You will need your Github username, Github access token and the Github repository name where the index.html file you wish to deploy is stored.
3. Navigate to the **user-data.sh** file inside the **infrastructure** directory. Change **username**, **git-token** and **repository values** to the correct corresponding values from the previous steps.
4. Line 6 in user-data.sh is the path to the directoty of where the index.html is stored inside your Github repository. For example, if the index.html was stored in the module directory inside the infrastucutre directory in this repo, line 6 would read cd /infrastructure/module. Correct line 6 to the relevant path.
5. Run **terraform init**
6. Run **terraform apply**

