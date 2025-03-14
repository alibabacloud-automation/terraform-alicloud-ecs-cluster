# Output the IDs of the ECS instances created
output "this_ids" {
  description = "The IDs of the ECS instances."
  value       = join(",", alicloud_instance.default[*].id)
}

output "this_availability_zone" {
  description = "The availability zone of the ECS instances."
  value       = alicloud_instance.default[0].availability_zone
}

output "this_vswitch_id" {
  description = "The ID of the VSwitch."
  value       = alicloud_instance.default[0].vswitch_id
}

output "this_security_group_ids" {
  description = "The IDs of the security groups."
  value       = alicloud_instance.default[0].security_groups
}

# Key pair outputs
output "this_key_name" {
  description = "The name of the key pair."
  value       = alicloud_instance.default[0].key_name
}

output "this_image_id" {
  description = "The ID of the image used to create the instance."
  value       = alicloud_instance.default[0].image_id
}

output "this_instance_type" {
  description = "The instance type."
  value       = alicloud_instance.default[0].instance_type
}

output "this_private_ips" {
  description = "The private IP address of the instance."
  value       = alicloud_instance.default[0].private_ip
}

output "this_access_internet_ip" {
  description = "The snat IP of the snat entry."
  value       = alicloud_snat_entry.default[*].snat_ip
}

output "this_access_instance_ip" {
  description = "The external IP address of the forward entry."
  value       = alicloud_forward_entry.default[*].external_ip
}