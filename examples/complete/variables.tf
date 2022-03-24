# vpc, vswitch and security group
variable "this_module_name" {
  description = "The name of the module."
  type        = string
  default     = "tf-testacc-module-name"
}

# Ecs instance variables
variable "instance_name" {
  description = "Name used on all instances as prefix. Default to `this_module_name`."
  type        = string
  default     = "tf-testacc-instance-name"
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

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
}

variable "password" {
  description = "The password of instance."
  type        = string
  default     = "YourPassword123!"
}

variable "user_data" {
  description = "User data to pass to instance on boot"
  type        = string
  default     = "tf-user-data"
}

variable "period" {
  description = "The period of instance when instance charge type is 'PrePaid'."
  type        = number
  default     = 1
}

variable "instance_tags" {
  description = "Used to mark specified ecs instance."
  type        = map(string)
  default = {
    Name = "ECS"
  }
}

#alicloud_eip
variable "eip_bandwidth" {
  description = "The specification of the eip bandwidth."
  type        = string
  default     = "10"
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