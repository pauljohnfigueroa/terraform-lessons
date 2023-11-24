terraform {
  required_providers {
    # You can also set a version constraint for each provider defined in the required_providers block.
    aws = {
      source  = "hashicorp/aws" # defines an optional hostname, a namespace, and the provider type.
      version = "~> 5.0"        # optional
    }
  }
  required_version = ">= 1.2.0"

#   backend "s3" {
#     bucket = "mybucket"
#     key    = "path/to/my/key"
#     region = "us-east-1"
#   }

}


# The provider block configures the specified provider, 
# in this case aws. A provider is a plugin that 
# Terraform uses to create and manage your resources.
provider "aws" {
  region = "us-east-1"
}

# Use resource blocks to define components of your infrastructure. 
# A resource might be a physical or virtual component such as an 
# EC2 instance, or it can be a logical resource such as a Heroku application.
resource "aws_instance" "app_server" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformTutorialInstance"
  }
}

