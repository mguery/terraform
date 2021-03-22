# terraform
Terraform notes and steps completed. Plus, mistakes I made along the way. 

- [x] Create AWS account - user = 'terraform'
- [x] Powershell - right click and run as Admin
- [x] Install chocolatey. [Copy and paste code in Powershell](https://chocolatey.org/install). Then 'choco install terraform'. Check version `terraform version`.
- [x] Install [AWS CLI](aws.amazon.com/cli). In Powershell, `aws configure`. (Error: Close and reopen Powershell if 'aws command not found' error.)
- [ ] After 'aws configure', add access key and secret key, then default region, and enter for JSON (or type 'json').
- [x] In VSC code (make sure Terraform extension is installed. Close and reopen, then `terraform init` first after install), terraform > resource > main.tf. Then cd into 'resource' folder. (Error: If there's an error when you `terraform init`, make sure you cd to 'resource' folder.)
- [x] Inside main.tf, add this: (Error: It's aws_vpc not aws-vpc!)
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
```
- [x] From terminal (inside 'resource' folder) - `terraform init` - prepare for commands, `terraform plan` - checks state file (which keeps track of all changes made). shows what was created and what needs to be created, `terraform apply` - runs plan, confirms - type 'yes' to approve and create resource/infrastructure. Check if [VPC is created](https://console.aws.amazon.com/vpc/home). And `terraform destroy` - deletes resource created. (init, plan, apply, destroy = lifecycle)

![created vpc in AWS](firstvpc.png)

- [x] Created variables. (Error: Make sure to close brackets.)
```
variable "inputname" {
  type = string
  description = "Set the name of the VPC."
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname 
  }
}
```
Then `terraform apply` and enter a value - the name of the VPC you want to create. Then 'yes' to create.
