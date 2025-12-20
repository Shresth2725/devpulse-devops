# Key Pair 
resource "aws_key_pair" "my_key" {
  key_name = "${var.env}-infra-devpulse-app-key"
  public_key = file("devpulse-key-ec2.pem.pub")

  tags = {
    Environment = var.env
  }
}

# VPC
resource "aws_default_vpc" "default" {
  
}

# Security Group
resource "aws_security_group" "my_security_group" {
  name = "${var.env}-devpulse-app-sg"
  description = "This will add a tf generated security group"
  vpc_id = aws_default_vpc.default.id

  # inbound rule
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
  } 

  ingress  {
    from_port = 80
    to_port = 80 
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open"
    } 

  ingress {
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    # OutBound Rule
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "my_instance" {
  count = var.instance_count

  key_name = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security_group.name]
  instance_type = var.instance_type
  ami = var.ec2_ami_id

  root_block_device {
    volume_size = var.env == "prd" ? 20 : 10
    volume_type = "gp3"
  }

  tags = {
    name = "${var.env}-devpulse-app-instance"
    Environment = var.env
  }
}