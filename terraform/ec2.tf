########################################
#       AMI for Ubuntu 22.04
########################################
data "aws_ami" "ubuntu_2204" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

########################################
#        JENKINS EC2 INSTANCE
########################################
resource "aws_instance" "jenkins" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "jenkins-server"
  }
}

########################################
#        NEXUS EC2 INSTANCE
########################################
resource "aws_instance" "nexus" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "nexus-server"
  }
}

########################################
#      SONARQUBE EC2 INSTANCE
########################################
resource "aws_instance" "sonarqube" {
  ami                    = data.aws_ami.ubuntu_2204.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public[1].id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "sonarqube-server"
  }
}

