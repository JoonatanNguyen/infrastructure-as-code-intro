# Infrastructure as code: Introduction to AWS & Terraform
This tech talk discusses AWS, infrastructure as code and Terraform

## Preparation
1. Make sure you have your AWS account set up properly according to this guide [Creating an IAM User](create-iam-user.md)
2. Copy the the `Access key ID` and `Secret access key` of the user just created
3. Configure AWS credentials file according to this guide [Configuration and Credential File Settings](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html). After this step, you would have a file `~/.aws/credentials` with this content:
```
[default]
aws_access_key_id=<your_iam_user_access_key>
aws_secret_access_key=<your_iam_user_secret_key>
```

And a file `~/.aws/config` with this content:
```
[default]
region=us-east-1
output=json
```

## How to run
1. Install Terraform as instructed here [Install terraform](https://learn.hashicorp.com/terraform/getting-started/install.html)
2. Run `terraform init` to download required providers
3. Run `terraform plan` to see what Terraform has planned and what resources are to be created
4. Run `terraform apply` to apply the plan and create the infrastructure
5. When not in use, run `terraform destroy` to destroy the infrastructure. NOTE: Always remember to do this or you'll incur charge from AWS for the resources that you left running.

## Notes
If you successfully run `terraform apply` but can't see your EC2 instances on the AWS Web Console, check that you're using `us-east-1` region (or whatever else non-default region you've configured in the project). You can change the region from the top right corner on the navigation bar of the AWS Web Console.
