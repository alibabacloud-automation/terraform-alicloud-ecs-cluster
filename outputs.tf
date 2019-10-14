// Output the IDs of the ECS instances created
output "this_ids" {
  value = join(",", alicloud_instance.default.*.id)
}

output "this_availability_zone" {
  value = alicloud_instance.default.0.availability_zone
}

output "this_vswitch_id" {
  value = alicloud_instance.default.0.vswitch_id
}

output "this_security_group_ids" {
  value = alicloud_instance.default.0.security_groups
}

# Key pair outputs
output "this_key_name" {
  value = alicloud_instance.default.0.key_name
}

output "this_image_id" {
  value = alicloud_instance.default.0.image_id
}

output "this_instance_type" {
  value = alicloud_instance.default.0.instance_type
}

output "this_private_ips" {
  value = alicloud_instance.default.0.private_ip
}

output "this_access_internet_ip" {
  value = alicloud_snat_entry.default.*.snat_ip
}

output "this_access_instance_ip" {
  value = alicloud_forward_entry.default.*.external_ip
}

