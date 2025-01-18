provider "aws" {
    region = var.region
  
}
resource "aws_iam_role" "role-elb" {
  name = "role-elb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "tf-ellb" {
  name = "aws-elasticbeanstalk-ec2-role" # use the same name as the default instance profile

  role = aws_iam_role.role-elb.name
}

# Attach the AWSElasticBeanstalkMulticontainerDocker policy
resource "aws_iam_policy_attachment" "role_elb_multicontainer_docker" {
  name       = "role-elb-multicontainer-docker-attachment"
  roles      = [aws_iam_role.role-elb.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

# Attach the AWSElasticBeanstalkWebTier policy
resource "aws_iam_policy_attachment" "role_elb_web_tier" {
  name       = "role-elb-web-tier-attachment"
  roles      = [aws_iam_role.role-elb.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

# Attach the AWSElasticBeanstalkWorkerTier policy
resource "aws_iam_policy_attachment" "role_elb_worker_tier" {
  name       = "role-elb-worker-tier-attachment"
  roles      = [aws_iam_role.role-elb.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_elastic_beanstalk_application" "tf-test" {
  name                = "test-app"
  description = "Testing tf-elb"
  
}

resource "aws_elastic_beanstalk_environment" "tf-test-env" {
  name                = "test-env"
  application = aws_elastic_beanstalk_application.tf-test.name
  solution_stack_name = "64bit Amazon Linux 2023 v4.3.2 running Python 3.12"
  tier = "WebServer"
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.tf-ellb.name
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCID"
    value = data.aws_vpc.default.id

  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnet)
  }
  setting {
    namespace = "aws:ec2:instances"
    name = "InstanceTypes"
    value = var.instance_type
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "true"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "public"
  }
}

output "url" {
  value = aws_elastic_beanstalk_environment.tf-test-env.endpoint_url
}