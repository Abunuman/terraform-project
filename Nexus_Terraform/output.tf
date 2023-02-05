output "public_ip1" {
  value = aws_instance.Nexus-server1.public_ip
}

output "public_ip2" {
  value = aws_instance.Nexus-server2.public_ip
}

output "public_ip3" {
  value = aws_instance.Nexus-server3.public_ip
}

output "Nexus-server" {
  value = aws_instance.Nexus-server1.id
}

output "Nexus-server2" {
  value = aws_instance.Nexus-server2.id
}

output "Nexus-server3" {
  value = aws_instance.Nexus-server3.id
}