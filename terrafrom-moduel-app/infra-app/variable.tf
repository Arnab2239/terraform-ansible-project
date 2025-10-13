variable "env" {
  description ="this my infra"
  type = string
}

variable "bucket_name" {
  description = "this my bucket name"
  type = string
}

variable "instance_count" {
  description = "this my instance count"
  type = string
}
variable "instance_type" {
  description = "this my instance type"
  type = string
}
variable "ec2_ami_id" {
  description = "this my ami id"
  type = string
}
variable "hash_key" {
  description = "this my hash key"
  type = string
}