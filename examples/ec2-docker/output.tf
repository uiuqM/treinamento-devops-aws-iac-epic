output "public_ip" {
  value = aws_instance.web.public_ip
}

output "ssh_cmd" {
  value = "ssh -i ~/.ssh/lab-iac ec2-user@${aws_instance.web.public_ip}"
}

output "http_url" {
  value = "http://${aws_instance.web.public_ip}"
}