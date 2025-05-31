terraform {
  backend "s3" {
    bucket = "tfstate-ritik-101"
    key    = "backend/10weeksofcloudops-demo.tfstate"
    region = "us-east-1"
    use_lockfile  = true
  }
}