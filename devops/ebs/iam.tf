# This IAM role is used by Elastic Beanstalk to manage resources in your AWS account.
resource "aws_iam_role" "eb_service_role" {
  name = "aws-elasticbeanstalk-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# Attach the Elastic Beanstalk Enhanced Health policy to the service role
# This policy allows Elastic Beanstalk to manage health monitoring and reporting for the environment.
resource "aws_iam_role_policy_attachment" "service_role_policy" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

# This IAM role is used by EC2 instances in your Elastic Beanstalk environment.
resource "aws_iam_role" "eb_instance_role" {
  name = "aws-elasticbeanstalk-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# Create an instance profile for the EC2 role
# Instance profiles are used to pass IAM role information to an EC2 instance when it is launched.
resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.eb_instance_role.name
}

# Attach the Elastic Beanstalk Web Tier policy to the instance role
# This policy allows the EC2 instances to interact with Elastic Beanstalk and other AWS services needed for a web application.
resource "aws_iam_role_policy_attachment" "instance_role_policy" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

# Attach the Elastic Beanstalk Multicontainer Docker policy to the instance role
# This policy allows the EC2 instances to run Docker containers in an Elastic Beanstalk environment.
resource "aws_iam_role_policy_attachment" "instance_profile_policy" {
  role       = aws_iam_role.eb_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}
## ECR
# ---
resource "aws_iam_policy" "ecr" {
  name        = "${local.prefix}-ECRFullAccessPolicy"
  description = "Provides full access to Amazon Elastic Container Registry (ECR)"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:BatchGetImage"
        ],
        Effect   = "Allow",
        Resource = aws_ecr_repository.app.arn,
      },
      {
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ecr" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = aws_iam_policy.ecr.arn
}

resource "aws_iam_instance_profile" "beanstalk_iam_instance_profile" {
  name = "${local.prefix}-beanstalk-iam-instance-profile"
  role = aws_iam_role.eb_service_role.name
}


resource "aws_iam_policy" "ecr_policy" {
  name        = "ECRFullAccessPolicy"
  description = "Provides full access to Amazon Elastic Container Registry (ECR)"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect: "Allow",
        Action: [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:GetRepositoryPolicy"
        ],
        Resource: "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_ecr_policy" {
  role       = "aws-elasticbeanstalk-ec2-role"
  policy_arn = aws_iam_policy.ecr_policy.arn
}
