# Create an S3 bucket to store the Dockerrun.aws.json file
resource "aws_s3_bucket" "ishwar_ebs" {
  bucket = "ishwar-backend-ebs"

  tags = {
    Name = "My APP EBS"
  }
}

# Upload the Dockerrun.aws.json file to the S3 bucket
resource "aws_s3_object" "ishwar_deployment" {
  bucket = aws_s3_bucket.ishwar_ebs.id
  key    = "Dockerrun.aws.json"
  source = "Dockerrun.aws.json"
}

# Create an Elastic Beanstalk application
resource "aws_elastic_beanstalk_application" "ishwar_backend_api" {
  name        = "ishwar-backend-api"
  description = "Elastic Beanstalk Application for ishwar Backend API"
}

# Create an Elastic Beanstalk application version
# The application version references the Dockerrun.aws.json file stored in S3.
resource "aws_elastic_beanstalk_application_version" "ishwar_ebs_version" {
  name = "${local.prefix}-ishwarai-backend"
  application = aws_elastic_beanstalk_application.ishwar_backend_api.name
  bucket      = aws_s3_bucket.ishwar_ebs.id
  key         = aws_s3_object.ishwar_deployment.key
  description = "application version created by terraform"
}

# Create an Elastic Beanstalk environment
# The environment uses the application version created above and deploys it using the specified solution stack.
resource "aws_elastic_beanstalk_environment" "ishwar_backend_env" {
  name                = "ishwar-backend-env"
  application         = aws_elastic_beanstalk_application.ishwar_backend_api.name
  solution_stack_name = "64bit Amazon Linux 2 v4.0.0 running Docker"
  version_label       = aws_elastic_beanstalk_application_version.ishwar_ebs_version.name
  tier                   = "WebServer"
  wait_for_ready_timeout = "10m"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_instance_profile.name
  }
  setting {
    name      = "InstancePort"
    namespace = "aws:cloudformation:template:parameter"
    value     = var.container_port
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = aws_vpc.main.id
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", [aws_subnet.public_a.id, aws_subnet.public_b.id])
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", [aws_subnet.public_a.id, aws_subnet.public_b.id])
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = "ishwarai-backend"
  }
   
  # Database environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_NAME"
    value     = aws_db_instance.main.db_name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USER"
    value     = var.db_username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = var.db_password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = aws_db_instance.main.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PORT"
    value     = "5432"
  }
}
