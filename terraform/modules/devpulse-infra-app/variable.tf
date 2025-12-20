variable "env" {
  description = "This is the environment for my infra"
  type = string
}

variable "instance_count" {
  description = "This is the no of EC2 instance for my infra"
  type = number
}

variable "instance_type" {
  description = "This is the type of Ec2 instance for my infra"
  type = string
}

variable "ec2_ami_id" {
  description = "This is the AMI ID for my ec2 instance of infra"
  type = string
}