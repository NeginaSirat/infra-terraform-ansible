variable "aws_region" {
  type    = string
  default = "us-west-2"
}
variable "vpc_cidr" { type = string, default = "10.0.0.0/16" }
variable "subnet_cidr" { type = string, default = "10.0.1.0/24" }
variable "instance_type" { type = string, default = "t3.medium" }
variable "key_name" { type = string, default = "demo-key" }
variable "public_key_path" { type = string, default = "~/.ssh/id_rsa.pub" }
variable "cluster_name" { type = string, default = "demo-eks" }
