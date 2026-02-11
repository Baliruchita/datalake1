terraform {
  backend "s3" {
    bucket               = "cats-pub-terraform-remote-backend-state1"
    key                  = "terraform.tfstate"
    region               = "eu-west-1"
    workspace_key_prefix = "terraform-cats-pub-hyderabad-ods/datalake/tfstates"
    dynamodb_table       = "cats-pub-terraform-remote-backend-483416847573"
   /* assume_role = {
      role_arn    = "arn:aws:iam::483416847573:user/datalake"
      max_retries = 3
    }*/
  }
}
