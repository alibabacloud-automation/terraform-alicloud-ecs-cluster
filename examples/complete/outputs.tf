output "this_ids" {
  description = "The IDs of the ECS instances."
  value       = module.example.this_ids
}

output "this_availability_zone" {
  description = "The availability zone of the ECS instances."
  value       = module.example.this_availability_zone
}

output "this_vswitch_id" {
  description = "The ID of the VSwitch."
  value       = module.example.this_vswitch_id
}

output "this_security_group_ids" {
  description = "The IDs of the security groups."
  value       = module.example.this_security_group_ids
}

# Key pair outputs
output "this_key_name" {
  description = "The name of the key pair."
  value       = module.example.this_key_name
}

output "this_image_id" {
  description = "The ID of the image used to create the instance."
  value       = module.example.this_image_id
}

output "this_instance_type" {
  description = "The instance type."
  value       = module.example.this_instance_type
}

output "this_private_ips" {
  description = "The private IP address of the instance."
  value       = module.example.this_private_ips
}

output "this_access_internet_ip" {
  description = "The snat IP of the snat entry."
  value       = module.example.this_access_internet_ip
}

output "this_access_instance_ip" {
  description = "The external IP address of the forward entry."
  value       = module.example.this_access_instance_ip
}