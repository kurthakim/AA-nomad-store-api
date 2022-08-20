terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.38"
    }
  }
  required_version = "1.2.7"
}

provider "aws" {
  region = "ap-southeast-1"
}

module "backend_config" {
  source = "../../../modules/backends/s3"

  bucket_name = "nomad-stage-state-buckets"
  dynamodb_name = "nomad-stage-table-locks"
}

terraform {
  backend "s3" {
    # set bucket details
    bucket = "nomad-stage-state-buckets"
    key = "global/s3/stage/terraform.tfstate"
    region = "ap-southeast-1"

    # dynamo db table details for locking
    dynamodb_table = "nomad-stage-table-locks"
    encrypt = true
  }
}