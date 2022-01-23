# Resume Foundations Project

Built a dev environment with AWS and Terraform - [course by Derek Morgan](https://courses.morethancertified.com/courses/enrolled/1641072)

launched aws resources with terraform, ssh into an ubuntu server

Notes
- **state file** stores info about your resources 
- **datasource** - a query of the AWS API to receive information needed to deploy a resource [tf docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)
- launch ec2 instance and grab AMI ID. go to AMI, public images in dropdown, and paste ami. grab owner #. 
- datasource file `ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*`
- generate key pair `ssh-keygen -t ed25519` \ `/c/Users/Marjy/.ssh/nameofkeyhere` \ to view keys `ls ~/.ssh`
- use **userdata** to bootstrap the instance and install the docker engine. to have an ec2 instance deployed with docker
- `terraform state show aws_instance.dev_node` \ grab public ip, `ssh -i ~/.ssh/mgkey ubuntu@public.ip.address.here`
- add EC2 host information into our SSH Config file - create windows-ssh-config.tpl file
- use a **[provisioner](https://www.terraform.io/language/resources/provisioners/syntax)** to configure the vscode on our local terminal to be able to ssh into our ec2 instance
- `terraform state list` \ `terraform apply -replace aws_instance.dev_node` replace fka taint
- `cat ~/.ssh/config` shows provisioner info 
- Remote-SSH Connect to host, click ip, linux, continue, new vscode window opens, docker --version to check if installed
- **terraform console** \ variable precedence - terraform.tfvars takes precedence
- use **conditional expressions** to choose the interpreter we need dynamically based on the defintion of the host_os variable \ `interpreter = var.host_os == "windows" ? ["Powershell", "-Command"] : ["bash", "-c"]`
- **outputs** outputs.tf `output "dev_ip" { value = aws_instance.dev_node.public_ip}` \ `terraform output`
