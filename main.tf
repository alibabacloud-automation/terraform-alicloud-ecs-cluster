# Images data source for image_id
data "alicloud_images" "default" {
  most_recent = var.most_recent
  owners      = var.owners
  name_regex  = var.image_name_regex
}

# Instance_types data source for instance_type
data "alicloud_instance_types" "default" {
  cpu_core_count    = var.cpu_core_count
  memory_size       = var.memory_size
  availability_zone = var.availability_zone != "" ? var.availability_zone : var.vswitch_id != "" ? data.alicloud_vswitches.default.vswitches[0].zone_id : data.alicloud_zones.default.ids[0]
}

# Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vswitches" "default" {
  ids = [var.vswitch_id]
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.this_module_name
  cidr_block = var.vpc_cidr
}

resource "alicloud_vswitch" "default" {
  vpc_id     = var.vpc_id == "" ? alicloud_vpc.default.id : var.vpc_id
  cidr_block = var.vswitch_cidr == "" ? var.vpc_cidr : var.vswitch_cidr
  zone_id    = var.availability_zone != "" ? var.availability_zone : data.alicloud_zones.default.ids[0]
}

resource "alicloud_security_group" "default" {
  security_group_name = var.this_module_name
  vpc_id              = var.vpc_id == "" ? alicloud_vpc.default.id : var.vpc_id
}

resource "alicloud_instance" "default" {
  count                = var.cluster_size
  image_id             = var.image_id == "" ? data.alicloud_images.default.images[0].id : var.image_id
  instance_type        = var.instance_type == "" ? data.alicloud_instance_types.default.instance_types[0].id : var.instance_type
  vswitch_id           = var.vswitch_id == "" ? alicloud_vswitch.default.id : var.vswitch_id
  security_groups      = length(var.security_group_ids) > 0 ? var.security_group_ids : [alicloud_security_group.default.id]
  instance_name        = var.cluster_size < 2 ? var.instance_name == "" ? var.this_module_name : var.instance_name : var.instance_name == "" ? format("%s-%s", var.this_module_name, count.index + 1) : format("%s-%s", var.instance_name, count.index + 1)
  internet_charge_type = var.internet_charge_type
  instance_charge_type = var.instance_charge_type
  system_disk_category = var.system_category
  system_disk_size     = var.system_size
  password             = var.password
  user_data            = var.user_data
  key_name             = var.key_name
  period               = var.period
  tags                 = var.instance_tags
}

resource "alicloud_eip" "default" {
  count                = 2
  bandwidth            = var.eip_bandwidth
  internet_charge_type = var.eip_internet_charge_type
}

resource "alicloud_nat_gateway" "default" {
  vpc_id               = var.vpc_id == "" ? alicloud_vpc.default.id : var.vpc_id
  vswitch_id           = var.vswitch_id == "" ? alicloud_vswitch.default.id : var.vswitch_id
  nat_gateway_name     = var.this_module_name
  nat_type             = var.nat_type
  specification        = var.specification
  internet_charge_type = var.nat_internet_charge_type
}

resource "alicloud_eip_association" "default" {
  count         = 2
  allocation_id = element(alicloud_eip.default[*].id, count.index)
  instance_id   = alicloud_nat_gateway.default.id
}

resource "alicloud_snat_entry" "default" {
  snat_table_id     = split(",", alicloud_nat_gateway.default.snat_table_ids)[0]
  source_vswitch_id = alicloud_vswitch.default.id
  snat_ip           = alicloud_eip.default[0].ip_address
}

resource "alicloud_forward_entry" "default" {
  forward_entry_name = var.this_module_name
  forward_table_id   = alicloud_nat_gateway.default.forward_table_ids
  external_ip        = alicloud_eip.default[1].ip_address
  external_port      = var.external_port
  ip_protocol        = var.ip_protocol
  internal_ip        = alicloud_instance.default[0].private_ip
  internal_port      = var.internal_port
}