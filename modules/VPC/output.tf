output "miniproj_name" {
  value = var.miniproj_name
}

output "vpc_id"{
  value = aws_vpc.main_vpc.id
}

output "sub_ass1"{
  value = aws_subnet.publicsubnet1.id
}

output "sub_ass2"{
  value = aws_subnet.publicsubnet2.id
}



output "route_table"{
  value = aws_route_table.pub-route.id
}

output "internet_gateway"{
  value = aws_internet_gateway.Nexus-igw.id
}