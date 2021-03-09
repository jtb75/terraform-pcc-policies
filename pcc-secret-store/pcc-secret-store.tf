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
  name        = "PCC-Secret-Store-${random_pet.pet_name.id}"
  description = "Prisma Cloud Compute Secret Store Policy"

  policy = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameter",
                "secretsmanager:GetSecretValue",
                "ssm:ListDocuments",
                "secretsmanager:ListSecrets"
            ],
            "Resource": "*"
        }
    ]
}

EOT
}

