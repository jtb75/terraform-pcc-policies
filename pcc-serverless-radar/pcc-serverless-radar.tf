terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.24.1"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "random_pet" "pet_name" {
  length    = 3
  separator = "-"
}

resource "aws_iam_policy" "policy" {
  name        = "PCC-Serverless-Radar-${random_pet.pet_name.id}"
  description = "Prisma Cloud Compute Serverless Radar Policy"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DescribeAlarms",
                "apigateway:GET",
                "cloudfront:ListDistributions",
                "cloudwatch:GetMetricData",
                "elasticloadbalancing:DescribeListeners",
                "elasticloadbalancing:DescribeListenerCertificates",
                "elasticloadbalancing:DescribeRules",
                "elasticloadbalancing:DescribeTargetGroups",
                "events:ListRules",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:GetRole",
                "iam:GetRolePolicy",
                "iam:ListAttachedRolePolicies",
                "iam:ListRolePolicies",
                "lambda:GetFunction",
                "lambda:GetPolicy",
                "lambda:ListFunctions",
                "lambda:ListAliases",
                "lambda:ListEventSourceMappings",
                "logs:DescribeSubscriptionFilters",
                "kms:Decrypt",
                "s3:GetBucketNotification"
            ],
            "Resource": "*"
        }
    ]
}

EOT
}

