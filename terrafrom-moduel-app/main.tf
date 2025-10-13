module "dev-infra" {
  source = "./infra-app"
  env = "dev"
  bucket_name = "infra-app-bucket"
  instance_count = 2
  instance_type = "t2.micro"
  ec2_ami_id = "ami-03aa99ddf5498ceb9"
  hash_key = "studentID"
}
module "stage-infra" {
  source = "./infra-app"
  env = "stage"
  bucket_name = "infra-app-bucket"
  instance_count = 1
  instance_type = "t2.small"
  ec2_ami_id = "ami-03aa99ddf5498ceb9"
  hash_key = "studentID"
}
module "prd-infra" {
  source = "./infra-app"
  env = "prd"
  bucket_name = "infra-app-bucket"
  instance_count = 1
  instance_type = "t2.medium"
  ec2_ami_id = "ami-03aa99ddf5498ceb9"
  hash_key = "studentID"
}