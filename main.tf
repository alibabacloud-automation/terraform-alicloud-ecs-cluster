provider "alicloud" {
  version              = ">=1.56.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/ecs-cluster"
}

// Images data source for image_id
data "alicloud_images" "default" {
  most_recent = true
  owners      = "system"
  name_regex  = var.image_name_regex
}

// Instance_types data source for instance_type
data "alicloud_instance_types" "default" {
  cpu_core_count    = var.cpu_core_count
  memory_size       = var.memory_size
  availability_zone = var.availability_zone != "" ? var.availability_zone : var.vswitch_id != "" ? join("", data.alicloud_vswitches.default.*.vswitches.0.zone_id) : join("", data.alicloud_zones.default.*.ids.0)
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  count                       = var.vswitch_id == "" ? 1 : 0
  available_resource_creation = "VSwitch"
}

data "alicloud_vswitches" "default" {
  count = var.vswitch_id == "" ? 0 : 1
  ids   = [var.vswitch_id]
}
resource "alicloud_vpc" "default" {
  count      = var.vpc_id == "" ? 1 : 0
  cidr_block = var.vpc_cidr
  name       = var.this_module_name
}

resource "alicloud_vswitch" "default" {
  count             = var.vswitch_id == "" ? 1 : 0
  availability_zone = var.availability_zone != "" ? var.availability_zone : join("", data.alicloud_zones.default.*.ids.0)
  cidr_block        = var.vswitch_cidr == "" ? var.vpc_cidr : var.vswitch_cidr
  vpc_id            = var.vpc_id == "" ? join("", alicloud_vpc.default.*.id) : var.vpc_id
}
resource "alicloud_security_group" "default" {
  count  = length(var.security_group_ids) > 0 ? 0 : 1
  vpc_id = var.vpc_id == "" ? join("", alicloud_vpc.default.*.id) : var.vpc_id
  name   = var.this_module_name
}

resource "alicloud_instance" "default" {
  count = var.cluster_size

  image_id        = var.image_id == "" ? concat(data.alicloud_images.default.images[0].id, [""])[0] : var.image_id
  instance_type   = var.instance_type == "" ? data.alicloud_instance_types.default.instance_types[0].id : var.instance_type
  security_groups = length(var.security_group_ids) > 0 ? var.security_group_ids : [alicloud_security_group.default[0].id]

  instance_name = var.cluster_size < 2 ? var.instance_name == "" ? var.this_module_name : var.instance_name : var.instance_name == "" ? format("%s-%s", var.this_module_name, count.index + 1) : format("%s-%s", var.instance_name, count.index + 1)

  internet_charge_type = var.internet_charge_type

  instance_charge_type = var.instance_charge_type
  system_disk_category = var.system_category
  system_disk_size     = var.system_size

  password = var.password

  vswitch_id = var.vswitch_id == "" ? alicloud_vswitch.default[0].id : var.vswitch_id

  user_data = var.user_data

  key_name = var.key_name

  period = var.period

  tags = {
    created_by   = var.instance_tags["created_by"]
    created_from = var.instance_tags["created_from"]
  }
}


resource "alicloud_eip" "default" {
  count                = 2
  internet_charge_type = "PayByTraffic"
  bandwidth            = 10
}

resource "alicloud_nat_gateway" "default" {
  vpc_id        = join("", alicloud_vpc.default.*.id)
  specification = "Small"
  name          = var.this_module_name
  nat_type      = var.nat_type
  vswitch_id = var.vswitch_id == "" ? alicloud_vswitch.default[0].id : var.vswitch_id
}

resource "alicloud_eip_association" "default" {
  count         = 2
  allocation_id = element(alicloud_eip.default.*.id, count.index)
  instance_id   = alicloud_nat_gateway.default.id
}

resource "alicloud_snat_entry" "default" {
  snat_table_id     = split(",", alicloud_nat_gateway.default.snat_table_ids)[0]
  source_vswitch_id = join("", alicloud_vswitch.default.*.id)
  snat_ip           = alicloud_eip.default.0.ip_address
}
resource "alicloud_forward_entry" "default" {
  count            = var.cluster_size > 0 ? 1 : 0
  name             = var.this_module_name
  forward_table_id = alicloud_nat_gateway.default.forward_table_ids
  external_ip      = alicloud_eip.default.1.ip_address
  external_port    = 22
  ip_protocol      = "tcp"
  internal_ip      = alicloud_instance.default.0.private_ip
  internal_port    = 22
}