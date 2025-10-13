output "ec2_public_ip" {
  value = { for name, instance in aws_instance.terra-ec2 : name => instance.public_ip }
}
