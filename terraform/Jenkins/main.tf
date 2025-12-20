module "jenkins-infra" {
  source         = "../modules/devpulse-infra-app"
  env            = "jenkins"
  instance_count = 1
  instance_type  = "t3.micro"
  ec2_ami_id     = "ami-0ecb62995f68bb549"
}
