terraform {
  backend "s3" {
    bucket = "backend-state-file1234"
    key    = "tf_state"
    region = "us-east-1"
  }
}
