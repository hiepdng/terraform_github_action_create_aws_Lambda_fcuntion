terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.61.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# IAM role for Lambda execution
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "python_lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# Package the Lambda function code
 data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.py"
  output_path = "${path.module}/lambda/function.zip"
}

# Lambda function
resource "aws_lambda_function" "my_lambda" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "my_terraform_lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  code_sha256   = data.archive_file.lambda_zip.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      ENVIRONMENT = "production"
      LOG_LEVEL   = "info"
    }
  }

  tags = {
    Environment = "production"
    Application = "example"
  }
}
