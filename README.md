# Infrastructure as code: Introduction to AWS & Terraform
This tech talk discusses AWS, infrastructure as code and Terraform

## Preparation
1. Make sure you have your AWS account set up properly according to this guide [Creating an IAM User](IAM_USER.md)
2. Copy the the `Access key ID` and `Secret access key` of the user just created
3. Configure AWS credentials file according to this guide [Configuration and Credential File Settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

## How to run
1. Install Terraform as instructed here [Install terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
2. Run `terraform init` to download required providers
3. Run `terraform plan` to see what Terraform has planned and what resources are to be created
4. Run `terraform apply` to apply the plan and create the infrastructure
5. When not in use, run `terraform destroy` to destroy the infrastructure
