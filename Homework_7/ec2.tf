provider "aws" {
  region = "us-east-1"
}

resource "aws_default_vpc" "default" {}

#data "template_file" "init" {
#  template = file("template/setup.sh")
#  vars = {
#    jdk_pkg = "openjdk-11-jdk"
#  }
#}

# provisioner "file" {
#   source      = "conf/proxy.conf"
#   destination = "/etc/apache2/mods-enabled/proxy.conf"
# }

resource "aws_instance" "webserver-wildfly" {
  #ami                    = "ami-0fe8bec493a81c7da" # Ubuntu 20
  ami                    = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.webserver-wildfly.id]
  key_name               = "2023_Instance"
  # user_data              = data.template_file.init.rendered
  user_data = file("template/setup_docker.sh")
  tags = {
    Name  = "Web Server"
    Owner = "adminuser"
  }
}

resource "aws_instance" "jenkins-slave" {
  #ami                    = "ami-0fe8bec493a81c7da" # Ubuntu 20
  ami                    = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.jenkins-slave.id]
  key_name               = "2023_Instance"
  # user_data              = data.template_file.init.rendered
  user_data = file("template/setup_slave.sh")
  tags = {
    Name  = "Jenkins Slave"
    Owner = "Andrey"
  }
}
resource "aws_instance" "jenkins-master" {
  #ami                    = "ami-0fe8bec493a81c7da" # Ubuntu 20
  ami                    = "ami-0fc5d935ebf8bc3bc" # Ubuntu 22
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.jenkins-master.id]
  key_name               = "2023_Instance"
  # user_data              = data.template_file.init.rendered
  user_data = file("template/setup_master.sh")
  tags = {
    Name  = "Jenkins Master"
    Owner = "Andrey"
  }
}
resource "aws_security_group" "webserver-wildfly" {
  name        = "WebServer Security Group 1"
  description = "Webserver-wildfly SecurityGroup"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web"
    Owner = "Andrey"
  }

}

output "webserver_ip_1" {
  value = aws_instance.webserver-wildfly.public_ip
}




resource "aws_security_group" "jenkins-slave" {
  name        = "WebServer Security Group 2"
  description = "Jenkins Slave SecurityGroup"
  vpc_id      = aws_default_vpc.default.id


  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web"
    Owner = "adminuser"
  }

}

output "webserver_ip2" {
  value = aws_instance.jenkins-slave.public_ip
}


resource "aws_security_group" "jenkins-master" {
  name        = "WebServer Security Group 3"
  description = "Jenkins Master SecurityGroup"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web"
    Owner = "Andrey"
  }

}

output "webserver_ip3" {
  value = aws_instance.jenkins-master.public_ip
}
