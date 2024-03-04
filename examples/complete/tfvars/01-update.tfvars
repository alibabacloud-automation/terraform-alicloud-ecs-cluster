# vpc, vswitch and security group
this_module_name = "update-tf-testacc-module-name"

# Ecs instance variables
instance_name        = "update-tf-testacc-instance-name"
internet_charge_type = "PayByTraffic"
password             = "YourPassword123!update"
user_data            = "update-tf-user-data"
period               = 2
instance_tags = {
  Name = "updateECS"
}

#alicloud_eip
eip_bandwidth = "20"

#alicloud_nat_gateway
specification = "Middle"

#alicloud_forward_entry
external_port = 90
ip_protocol   = "udp"
internal_port = 9090