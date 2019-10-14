variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "availability_zone" {
  description = "The available zone to launch ecs instance and other resources."
  default     = ""
}

variable "this_module_name" {
  default = "terraform-alicloud-ecs-cluster"
}

# Image variables
variable "image_id" {
  description = "The image id used to launch ecs instances. If not set, a system image with `image_name_regex` will be returned."
  default     = ""
}
variable "image_name_regex" {
  description = "The ECS image's name regex used to fetch specified image."
  default     = "^ubuntu_18.*_64"
}

# Instance typs variables
variable "instance_type" {
  description = "The instance type used to launch ecs instances. If not set, a random type with `cpu_core_count` and `memory_size` will be returned."
  default     = ""
}
variable "cpu_core_count" {
  description = "CPU core count used to fetch instance types."
  default     = 2
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  default     = 4
}
variable "vpc_id" {
  description = "The existing VPC ID. If not set, a new VPC will be created."
  default     = ""
}

# VSwitch  ID
variable "vswitch_id" {
  description = "The existing VSwitch ID. If not set, a new vswitch will be created."
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block used to launch a new VPC."
  default     = "172.16.0.0/16"
}

variable "vswitch_cidr" {
  description = "The CIDR block used to launch a new VSwitch. If not set, `vpc_cidr` will be used."
  default     = ""
}
# Security Group variables
variable "security_group_ids" {
  description = "List of security group ids used to create ECS instances. If not set, a new one will be created."
  type        = list(string)
  default     = []
}

# Key pair variables
variable "key_name" {
  description = "The key pair name used to config instances."
  default     = ""
}

variable "instance_name" {
  description = "Name used on all instances as prefix. Default to `this_module_name`."
  default     = ""
}

variable "password" {
  description = "The password of instance."
  default     = ""
}

variable "internet_charge_type" {
  description = "The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'."
  default     = "PayByTraffic"
}


variable "instance_charge_type" {
  description = "The charge type of instance. Choices are 'PostPaid' and 'PrePaid'."
  default     = "PostPaid"
}

variable "period" {
  description = "The period of instance when instance charge type is 'PrePaid'."
  default     = 1
}

variable "instance_tags" {
  description = "Used to mark specified ecs instance."
  type        = map(string)

  default = {
    created_by   = "Terraform"
    created_from = "module-tf-alicloud-ecs-cluster"
  }
}

variable "cluster_size" {
  description = "The number of ECS instances."
  default     = 6
}

variable "user_data" {
  description = "User data to pass to instance on boot"
  default     = ""
}

variable "system_category" {
  description = "The system disk category used to launch one or more ecs instances."
  default     = "cloud_efficiency"
}

variable "system_size" {
  description = "The system disk size used to launch one or more ecs instances."
  default     = "40"
}