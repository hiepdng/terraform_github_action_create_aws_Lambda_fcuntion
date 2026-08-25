## Automate create AWS Lambda Function using Terraform and GitHub Actions  

This is a complete setup to create AWS Lambda Fucntion using Terraform and GitHub Actions.

**Requirements:**  
Add your AWS credentials to your GitHub repository  
- AWS_ACCESS_KEY_ID: Your AWS access key
- AWS_SECRET_ACCESS_KEY: Your AWS secret access key

<br/>

#### <ins>Method 1:</ins> Deploy AWS Lambda Fucntion using CLI  
- Set Up AWS Authentication:  
    Run the below command and follow the instruction.  
```
aws configure
```
- Copy the main.tf to the current directory.  
- Deploy AWS Lambda Fucntion:  
```
tarraform init
terraform plan
terraform apply -auto-approve
```

- Destroy AWS Lambda Fucntion:
```
terraform init
terraform plan -destroy
terraform destroy -auto-approve
```

#### <ins>Method 2:</ins> Deploy AWS Lambda Fucntion using GitHub Actions
- The provided GitHub Action is for deploying the AWS Lambda Fucntion And they are triggered by workflow_dispatch. Change to other trigger if you wish.
- There are two Gihub Actions workflow files (deploy.yml and destroy.yml).
    - deploy.yml: Deploy the AWS Lambda Fucntion.
    - destroy.yml: Destroy AWS Lambda Fucntion.

<br/>

**Checking:**  
```
aws dynamodb list-tables
aws dynamodb describe-table --table-name GameScores
aws dynamodb describe-table --table-name GameScores --output table
aws dynamodb scan --table-name GameScores --output table      
aws dynamodb describe-table \
