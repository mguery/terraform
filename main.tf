provider "aws" {
  region = "us-east-1"
}

/*
Steps for challenge 2
create a DB server and output the private ip
create a web server with a fixed public ip
create a SG for the web server opening ports 80 and 443
run provided script on server - server-script.sh
*/

resource "aws_instance" "db" {
  ami = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"

  tags = {
    Name = "DB Server"
  }
}

resource "aws_instance" "web" {
  ami = "ami-0533f2ba8a1995cf9"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_traffic.name]
  user_data = file("server-script.sh")

  tags = {
    Name = "Web Server"
  }
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
}

variable "ingress" {
  type = list(number)
  default = [80,443]
}

variable "egress" {
  type = list(number)
  default = [80,443]
}

resource "aws_security_group" "web_traffic" {
  name = "Allow web traffic"

  dynamic "ingress" {
    iterator = port 
    for_each = var.ingress 
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port 
    for_each = var.egress 
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }  
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}

output "PublicIP" {
  value = aws_eip.web_ip.public_ip
}