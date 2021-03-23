# terraform
Terraform notes and steps completed. Plus, mistakes I made along the way. 

- [x] Create AWS account - user = 'terraform'
- [x] Powershell - right click and run as Admin
- [x] Install chocolatey. [Copy and paste code in Powershell](https://chocolatey.org/install). Then 'choco install terraform'. Check version `terraform version`.
- [x] Install [AWS CLI](aws.amazon.com/cli). In Powershell, `aws configure`. (Error: Close and reopen Powershell if 'aws command not found' error.)
- [x] After 'aws configure', add access key and secret key, then default region, and enter for JSON (or type 'json').
- [x] In VSC code (make sure Terraform extension is installed. Close and reopen, then `terraform init` first after install), terraform > resource > main.tf. Then cd into 'resource' folder. (Error: If there's an error when you `terraform init`, make sure you cd to 'resource' folder.)
- [x] Inside main.tf (Terraform config file), add this: (Error: It's aws_vpc not aws-vpc!)
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}
```
- [x] From terminal (inside 'resource' folder) - `terraform init` -> `terraform plan` ->  `terraform apply` -> type 'yes' to approve, check if [VPC is created](https://console.aws.amazon.com/vpc/home) -> then `terraform destroy`. 

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

---
Notes from [Getting Started with Terraform](https://cloudskills.io/blog/terraform-aws-1) and [Intro to Terraform](https://hackernoon.com/hashicorps-terraform-a-introduction-7f2034ae)

Syntax
```
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```
Workflow = init –> plan –> apply –> destroy (IPAD or IAD)
1. `terraform init` - This command downloads the plugins then initialize the backend.
2. `terraform plan` - This generates execution plan. Checks for syntax errors, API authentication, state verification, etc. Shows what needs to be fixed, what was created, and what needs to be created.
3. `terraform apply` -  This executes the plan. Type 'yes' to approve and create resource/infrastructure.
4. `terraform destroy` - This destroys any resources made. Also confirm with 'yes'.

[Terraform references for AWS](https://registry.terraform.io/providers/hashicorp/aws/latest)
---

Create an instance
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}
```

---

Create an EIP
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami           = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
}

resource "aws_eip" "elasticeip" {
  instance = aws_instance.ec2.id
}

output "EIP" {
  value = aws_eip.elasticeip.public_ip
}
```

---

