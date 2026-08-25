## Automate create AWS Lambda Function using Terraform and GitHub Actions  

This is a complete setup to create AWS Lambda Function (Python function) using Terraform and GitHub Actions.

**Requirements:**  
Add your AWS credentials to your GitHub repository  
- AWS_ACCESS_KEY_ID: Your AWS access key
- AWS_SECRET_ACCESS_KEY: Your AWS secret access key

<br/>

#### <ins>Method 1:</ins> Deploy AWS Lambda Function using CLI  
- Set Up AWS Authentication:  
    Run the below command and follow the instruction.  
```
aws configure
```
- Copy the main.tf to the current directory.  
- Deploy AWS Lambda Function:  
```
tarraform init
terraform plan
terraform apply -auto-approve
```

- Destroy AWS Lambda Function:
```
terraform init
terraform plan -destroy
terraform destroy -auto-approve
```

#### <ins>Method 2:</ins> Deploy AWS Lambda Function using GitHub Actions
- The provided GitHub Action is for deploying the AWS Lambda Function And they are triggered by workflow_dispatch. Change to other trigger if you wish.
- There are two Gihub Actions workflow files (deploy.yml and destroy.yml).
    - deploy.yml: Deploy the AWS Lambda Function.
    - destroy.yml: Destroy AWS Lambda Function.

<br/>

**Checking:**  
```
aws lambda invoke \
  --region us-east-1 \
  --function my_terraform_lambda_function \
  --payload '{"name": "LocalStack User"}' \
  output.json

cat output.json
{"statusCode": 200, "body": "{\"message\": \"Hello, LocalStack User from local AWS Lambda!\"}"}
```
