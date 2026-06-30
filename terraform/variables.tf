variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "Ubuntu AMI ID"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.micro"   # Use t2.micro or t3.micro if eligible in your account
}

variable "key_name" {
  description = "devops_key"
  type        = string
}