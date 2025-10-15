provider "alicloud" {
  region = "cn-zhangjiakou"
}

data "alicloud_zones" "default" {
}

data "alicloud_instance_types" "default" {
  availability_zone    = data.alicloud_zones.default.zones[0].id
  cpu_core_count       = 2
  memory_size          = 8
  instance_type_family = "ecs.g9i"
}

data "alicloud_images" "default" {
  most_recent   = true
  instance_type = data.alicloud_instance_types.default.instance_types[0].id
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = "key_pair_name_${random_integer.default.result}"
}

module "example" {
  source = "../.."

  #alicloud_images
  most_recent      = true
  owners           = "system"
  image_name_regex = "^ubuntu_18.*64"

  #alicloud_instance_types
  cpu_core_count = 1
  memory_size    = 2

  #alicloud_vpc, alicloud_vswitch and alicloud_security_group
  this_module_name  = var.this_module_name
  vpc_cidr          = "172.16.0.0/16"
  vswitch_cidr      = "172.16.0.0/21"
  availability_zone = data.alicloud_zones.default.zones[0].id

  #alicloud_instance
  cluster_size = 2

  image_id             = data.alicloud_images.default.images[0].id
  instance_type        = data.alicloud_instance_types.default.instance_types[0].id
  instance_name        = var.instance_name
  internet_charge_type = var.internet_charge_type
  instance_charge_type = var.instance_charge_type
  system_category      = "cloud_essd"
  system_size          = var.system_size
  password             = var.password
  user_data            = var.user_data
  key_name             = alicloud_ecs_key_pair.default.id
  period               = var.period
  instance_tags        = var.instance_tags

  #alicloud_eip
  eip_bandwidth            = var.eip_bandwidth
  eip_internet_charge_type = "PayByTraffic"

  #alicloud_nat_gateway
  nat_type                 = var.nat_type
  specification            = var.specification
  nat_internet_charge_type = "PayByLcu"

  #alicloud_forward_entry
  external_port = var.external_port
  ip_protocol   = var.ip_protocol
  internal_port = var.internal_port

}