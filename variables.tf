variable "region" {
    description = "Please state the region"
  default = "us-east-1"
}

#variable "language" {
 #  description = "Please state the programming language"
  #}

#variable "vpc_id" {
 # description = "ID of the VPC where the Elastic Beanstalk environment will be deployed"
# default = data.aws_vpc.default.id #Edit it with your VPC ID
#}

variable "subnet" {
    description = "Subnet ID of first zone"
    default = ["subnet-.." , "subnet-.."] #Edit it with your subnet ids
  
}

variable "instance_type" {
    description = "The type of instance"
  default = "t2.micro"
}

data "aws_vpc" "default" {                                                                                                                            
  default = true                                                                                                                                      
}    

