terraform {
  backend "s3" {
    bucket = "pjsf-terra-bucket"
    key    = "pjsf-terra-bucket/multi-resource-exercise"
    region = "us-east-1"
  }
}