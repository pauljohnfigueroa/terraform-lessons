terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # The region where the environment 
}

# ECR Repository
resource "aws_ecr_repository" "node-app-cluster" {
  name = "node-app-demo-cluster"
}

# ECS Cluster
resource "aws_ecs_cluster" "node-cluster" {
  name = "node-app-cluster"
}

# resource "aws_ecs_task_definition" node-app-task {
# 	family = ""
# }


