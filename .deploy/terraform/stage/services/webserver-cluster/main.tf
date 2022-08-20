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

# terraform backend remote for state data
terraform {
  backend "s3" {
    # set bucket details
    bucket = "nomad-stage-state-buckets"
    key = "stage/services/webserver-cluster/terraform.tfstate"
    region = "ap-southeast-1"

    # dynamo db table details for locking
    dynamodb_table = "nomad-stage-table-locks"
    encrypt = true
  }
}
module "webserver_cluster" {
  source= "../../../modules/services/webserver-cluster"

  cluster_name = "webservers-stage"
  stripe_secret_key = var.stripe_secret_key
  web_app_url = var.web_app_url
  web_hook_secret = var.web_hook_secret

  dns_name = "dev-api"
  log_profile_name = "nomad_stage_logs_profile"

  instance_type = "t2.micro"
  min_size = 2
  max_size = 3
}