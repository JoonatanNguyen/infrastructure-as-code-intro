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
4. Run `terraform apply` to apply the plan and create the infrastructure (enter `yes` when prompted)
5. When not in use, run `terraform destroy` to destroy the infrastructure. NOTE: Always remember to do this or you'll incur charge from AWS for the resources that you left running.

## Notes
If you successfully run `terraform apply` but can't see your EC2 instances on the AWS Web Console, check that you're using `us-east-1` region (or whatever else non-default region you've configured in the project). You can change the region from the top right corner on the navigation bar of the AWS Web Console.

## Senarios
We'll be having 2 senarios for our hands-on lab.

### A single Web server
In this senario, we'll bring up a single EC2 instance to run a simple NodeJS Web server. The following resources will be created:
* A VPC with 2 public subnets & 2 private subnets
* One Internet gateway
* One NAT gateway
* Route tables
* Security groups
* Key pair
* One EC2 instance in public subnet 
* Provisioning script for a simple ExpressJS based Web server

Just follow the steps in `How to run` and you'll get the output of the public IP address of the instance. Paste that IP on the browser and you'll the response from the Web server.


### A cluster of Web server
In this senario, we'll bring up a cluster of Web server via Autoscaling. A Load balancer is also created to handle and distribute the requests to different Web servers. In addition to the resources as in the `A single Web server` senario, we'll also bring up the following ones:
* Launch configuration
* Auto scaling group
* Application load balancer
* Cloudwatch metric alarms
* Scaling policies

In order to run this senario, create a file named `terraform.tfvars` in the project root and put this into it:
```
ec2_enable_cluster = true
```

And then run `terraform apply`. Once succeeded, you'll get the domain name of the load balancer. Copy & paste it to browser you'll see the response.

#### Test the autoscaling
To see how autoscaling works in action, follow these steps:
1. Go to AWS Web Console at [EC2 instances](https://console.aws.amazon.com/ec2/home?region=us-east-1#Instances:sort=instanceId)
2. Click on one of the running EC2 instance and select `IPv4 Public IP`
3. From the project root, run `./ssh.sh <public_ip>`
4. Once you're in the instance terminal, run: `stress-ng -c 0 -l 90` to fake the situtation that the CPU usage goes up to 90% (which will trigger the autoscaling to spawn a new Web server instance)
5. Wait for few minutes and check the EC2 instances console in step 1., you'll see a new instance created.
6. From the project root, run `./test-lb.sh`, you'll see different IP addresses from the response. That's because Load balancer is routing request to different Web server instances.
7. From the terminal of the Web server console in step 4., type: `Ctrl + C` to stop `stress-ng`.
8. After few minutes (this can be a bit longer), you'll see one Web server instance to be terminated.
9. In order to exit from the Web server instance SSH terminal, type `exit`
10. Always remember to run `terraform destroy` (type `yes` when prompted) to destroy the resources you've created or you'll get a bill from AWS.
