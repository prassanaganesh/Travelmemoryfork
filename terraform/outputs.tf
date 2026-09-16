output "web_public_ip" {

  description = "Public IP address of TravelMemory web server"

  value = aws_instance.web.public_ip
}


output "web_public_dns" {

  description = "Public DNS of TravelMemory web server"

  value = aws_instance.web.public_dns
}


output "database_private_ip" {

  description = "Private IP address of MongoDB server"

  value = aws_instance.database.private_ip
}


output "application_url" {

  description = "TravelMemory URL"

  value = "http://${aws_instance.web.public_ip}"
}


output "ssh_command" {

  description = "SSH command for web server"

  value = "ssh -i ~/.ssh/travelmemory-key ubuntu@${aws_instance.web.public_ip}"
}
