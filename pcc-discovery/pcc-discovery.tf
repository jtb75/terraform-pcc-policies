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
  name        = "PCC-Discovery-${random_pet.pet_name.id}"
  description = "Prisma Cloud Compute Discovery Policy"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "lambda:GetFunction",
                "kms:Decrypt",
                "lambda:ListFunctions",
                "ecr:DescribeRepositories",
                "eks:DescribeCluster",
                "ecs:ListContainerInstances",
                "eks:ListClusters",
                "ecs:DescribeClusters",
                "ecs:ListClusters",
                "ec2:DescribeRegions"
            ],
            "Resource": "*"
        }
    ]
}
EOT
}

