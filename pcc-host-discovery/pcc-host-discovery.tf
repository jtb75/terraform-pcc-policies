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
  name        = "PCC-Host-Discovery-${random_pet.pet_name.id}"
  description = "Prisma Cloud Compute Host Discovery Policy"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ssm:CreateAssociation",
                "ec2:DescribeImages",
                "ssm:SendCommand",
                "ssm:DescribeInstanceInformation",
                "ssm:ListCommandInvocations",
                "ssm:CancelCommand"

            ],
            "Resource": "*"
        }
    ]
}

EOT
}

