variable "region" {
  description = "(Deprecated from version 1.1.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

# Images data source for image_id
variable "most_recent" {
  description = "If more than one result are returned, select the most recent one."
  type        = bool
  default     = true
}

variable "owners" {
  description = "Filter results by a specific image owner. Valid items are 'system', 'self', 'others', 'marketplace'."
  type        = string
  default     = "system"
}

variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  type        = string
  default     = ""
}

# Instance_types data source for instance_type
variable "cpu_core_count" {
  description = "CPU core count used to fetch instance types."
  type        = number
  default     = 2
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  type        = number
  default     = 4
}

# vpc, vswitch and security group
variable "this_module_name" {
  description = "The name of the module."
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block used to launch a new VPC."
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The existing VPC ID. If not set, a new VPC will be created."
  type        = string
  default     = ""
}

variable "vswitch_cidr" {
  description = "The CIDR block used to launch a new VSwitch. If not set, `vpc_cidr` will be used."
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "The available zone to launch ecs instance and other resources."
  type        = string
  default     = ""
}

# Ecs instance variables
variable "cluster_size" {
  description = "The number of ECS instances."
  type        = number
  default     = 6
}

variable "image_id" {
  description = "The image id used to launch ecs instances. If not set, a system image with `image_name_regex` will be returned."
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The instance type used to launch ecs instances. If not set, a random type with `cpu_core_count` and `memory_size` will be returned."
  type        = string
  default     = ""
}

variable "vswitch_id" {
  description = "The existing VSwitch ID. If not set, a new vswitch will be created."
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "List of security group ids used to create ECS instances. If not set, a new one will be created."
  type        = list(string)
  default     = []
}

variable "instance_name" {
  description = "Name used on all instances as prefix. Default to `this_module_name`."
  type        = string
  default     = ""
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  type        = string
  default     = "PayByTraffic"
}

variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  type        = string
  default     = "PostPaid"
}

variable "system_category" {
  description = "The system disk category used to launch one or more ecs instances."
  type        = string
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
}

variable "password" {
  description = "The password of instance."
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data to pass to instance on boot"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The key pair name used to config instances."
  type        = string
  default     = ""
}

variable "period" {
  description = "The period of instance when instance charge type is 'PrePaid'."
  type        = number
  default     = 1
}

variable "instance_tags" {
  description = "Used to mark specified ecs instance."
  type        = map(string)
  default     = {}
}

#alicloud_eip
variable "eip_bandwidth" {
  description = "The specification of the eip bandwidth."
  type        = string
  default     = "10"
}

variable "eip_internet_charge_type" {
  description = "The specification of the eip internet charge type."
  type        = string
  default     = "PayByTraffic"
}

#alicloud_nat_gateway
variable "nat_type" {
  description = "The type of NAT gateway."
  type        = string
  default     = "Enhanced"
}

variable "specification" {
  description = "The specification of nat gateway."
  type        = string
  default     = "Small"
}

variable "nat_internet_charge_type" {
  description = "The internet charge type."
  type        = string
  default     = "PayByLcu"
}

#alicloud_forward_entry
variable "external_port" {
  description = "The external port, valid value is 1~65535|any."
  type        = number
  default     = 22
}

variable "ip_protocol" {
  description = "The ip protocol, valid value is tcp|udp|any."
  type        = string
  default     = "tcp"
}

variable "internal_port" {
  description = "The internal port, valid value is 1~65535|any."
  type        = number
  default     = 22
}