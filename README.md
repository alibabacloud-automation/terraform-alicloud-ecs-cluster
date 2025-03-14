Terraform module which creates ECS cluster on Alibaba Cloud
terraform-alicloud-ecs-cluster

A terraform module to provide classic load balance architecture in alibaba cloud.

![image](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-cluster/blob/master/architecture.png)

----------------------

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


    ```
    module "ecs-cluster" {
        source = "terraform-alicloud-modules/ecs-cluster/alicloud"
        cluster_size = 6
        vpc_cidr = "10.1.0.0/16"
        vswitch_cidr = "10.1.2.0/24"

        system_category = "cloud_ssd"
        system_size = "100"
    }
    ```

2. Setting `access_key` and `secret_key` values through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY

Conditional creation
--------------------
This example supports using existing VPC and VSwitch to create ECS Cluster conditionally.

#### Using existing vpc and vswitch for the cluster.

You can specify the following user-defined arguments:

* vpc_id: A existing vpc ID
* vswitch_id: A existing vpc ID

**Note:** At present, not all availability zone supports launching RDS instance. If you want to using existing vswitches,
you must ensure the specified vswitches can creating RDS instance.

```
module "classic-load-balance" {
    source = "terraform-alicloud-classic-load-balance"
    cluster_size = 6
    vpc_id = "vpc-abc12345"
    vswitch_id = "vsw-abc12345
}
```

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version              = ">=1.56.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/ecs-cluster"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

```hcl
module "ecs-cluster" {
   source       = "terraform-alicloud-modules/ecs-cluster/alicloud"
   version      = "1.0.0"
   region       = "cn-beijing"
   cluster_size = 6
   vpc_cidr     = "10.1.0.0/16"
   // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region = "cn-beijing"
}
module "ecs-cluster" {
   source       = "terraform-alicloud-modules/ecs-cluster/alicloud"
   cluster_size = 6
   vpc_cidr     = "10.1.0.0/16"
   // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
   region = "cn-beijing"
   alias  = "bj"
}
module "ecs-cluster" {
   source       = "terraform-alicloud-modules/ecs-cluster/alicloud"
   providers    = {
      alicloud = alicloud.bj
   }
   cluster_size = 6
   vpc_cidr     = "10.1.0.0/16"
   // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_eip.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/eip) | resource |
| [alicloud_eip_association.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/eip_association) | resource |
| [alicloud_forward_entry.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/forward_entry) | resource |
| [alicloud_instance.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_nat_gateway.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/nat_gateway) | resource |
| [alicloud_security_group.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_snat_entry.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/snat_entry) | resource |
| [alicloud_vpc.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/vswitch) | resource |
| [alicloud_images.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/images) | data source |
| [alicloud_instance_types.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/instance_types) | data source |
| [alicloud_vswitches.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/vswitches) | data source |
| [alicloud_zones.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | The available zone to launch ecs instance and other resources. | `string` | `""` | no |
| <a name="input_cluster_size"></a> [cluster\_size](#input\_cluster\_size) | The number of ECS instances. | `number` | `6` | no |
| <a name="input_cpu_core_count"></a> [cpu\_core\_count](#input\_cpu\_core\_count) | CPU core count used to fetch instance types. | `number` | `2` | no |
| <a name="input_eip_bandwidth"></a> [eip\_bandwidth](#input\_eip\_bandwidth) | The specification of the eip bandwidth. | `string` | `"10"` | no |
| <a name="input_eip_internet_charge_type"></a> [eip\_internet\_charge\_type](#input\_eip\_internet\_charge\_type) | The specification of the eip internet charge type. | `string` | `"PayByTraffic"` | no |
| <a name="input_external_port"></a> [external\_port](#input\_external\_port) | The external port, valid value is 1~65535\|any. | `number` | `22` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The image id used to launch ecs instances. If not set, a system image with `image_name_regex` will be returned. | `string` | `""` | no |
| <a name="input_image_name_regex"></a> [image\_name\_regex](#input\_image\_name\_regex) | The ECS image's name regex used to fetch specified image. | `string` | `""` | no |
| <a name="input_instance_charge_type"></a> [instance\_charge\_type](#input\_instance\_charge\_type) | The charge type of instance. Choices are 'PostPaid' and 'PrePaid'. | `string` | `"PostPaid"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name used on all instances as prefix. Default to `this_module_name`. | `string` | `""` | no |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | Used to mark specified ecs instance. | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type used to launch ecs instances. If not set, a random type with `cpu_core_count` and `memory_size` will be returned. | `string` | `""` | no |
| <a name="input_internal_port"></a> [internal\_port](#input\_internal\_port) | The internal port, valid value is 1~65535\|any. | `number` | `22` | no |
| <a name="input_internet_charge_type"></a> [internet\_charge\_type](#input\_internet\_charge\_type) | The internet charge type of instance. Choices are 'PayByTraffic' and 'PayByBandwidth'. | `string` | `"PayByTraffic"` | no |
| <a name="input_ip_protocol"></a> [ip\_protocol](#input\_ip\_protocol) | The ip protocol, valid value is tcp\|udp\|any. | `string` | `"tcp"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The key pair name used to config instances. | `string` | `""` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory size used to fetch instance types. | `number` | `4` | no |
| <a name="input_most_recent"></a> [most\_recent](#input\_most\_recent) | If more than one result are returned, select the most recent one. | `bool` | `true` | no |
| <a name="input_nat_internet_charge_type"></a> [nat\_internet\_charge\_type](#input\_nat\_internet\_charge\_type) | The internet charge type. | `string` | `"PayByLcu"` | no |
| <a name="input_nat_type"></a> [nat\_type](#input\_nat\_type) | The type of NAT gateway. | `string` | `"Enhanced"` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | Filter results by a specific image owner. Valid items are 'system', 'self', 'others', 'marketplace'. | `string` | `"system"` | no |
| <a name="input_password"></a> [password](#input\_password) | The password of instance. | `string` | `""` | no |
| <a name="input_period"></a> [period](#input\_period) | The period of instance when instance charge type is 'PrePaid'. | `number` | `1` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group ids used to create ECS instances. If not set, a new one will be created. | `list(string)` | `[]` | no |
| <a name="input_specification"></a> [specification](#input\_specification) | The specification of nat gateway. | `string` | `"Small"` | no |
| <a name="input_system_category"></a> [system\_category](#input\_system\_category) | The system disk category used to launch one or more ecs instances. | `string` | `"cloud_efficiency"` | no |
| <a name="input_system_size"></a> [system\_size](#input\_system\_size) | The system disk size used to launch one or more ecs instances. | `number` | `40` | no |
| <a name="input_this_module_name"></a> [this\_module\_name](#input\_this\_module\_name) | The name of the module. | `string` | `""` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data to pass to instance on boot | `string` | `""` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block used to launch a new VPC. | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The existing VPC ID. If not set, a new VPC will be created. | `string` | `""` | no |
| <a name="input_vswitch_cidr"></a> [vswitch\_cidr](#input\_vswitch\_cidr) | The CIDR block used to launch a new VSwitch. If not set, `vpc_cidr` will be used. | `string` | `""` | no |
| <a name="input_vswitch_id"></a> [vswitch\_id](#input\_vswitch\_id) | The existing VSwitch ID. If not set, a new vswitch will be created. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_access_instance_ip"></a> [this\_access\_instance\_ip](#output\_this\_access\_instance\_ip) | The external IP address of the forward entry. |
| <a name="output_this_access_internet_ip"></a> [this\_access\_internet\_ip](#output\_this\_access\_internet\_ip) | The snat IP of the snat entry. |
| <a name="output_this_availability_zone"></a> [this\_availability\_zone](#output\_this\_availability\_zone) | The availability zone of the ECS instances. |
| <a name="output_this_ids"></a> [this\_ids](#output\_this\_ids) | The IDs of the ECS instances. |
| <a name="output_this_image_id"></a> [this\_image\_id](#output\_this\_image\_id) | The ID of the image used to create the instance. |
| <a name="output_this_instance_type"></a> [this\_instance\_type](#output\_this\_instance\_type) | The instance type. |
| <a name="output_this_key_name"></a> [this\_key\_name](#output\_this\_key\_name) | The name of the key pair. |
| <a name="output_this_private_ips"></a> [this\_private\_ips](#output\_this\_private\_ips) | The private IP address of the instance. |
| <a name="output_this_security_group_ids"></a> [this\_security\_group\_ids](#output\_this\_security\_group\_ids) | The IDs of the security groups. |
| <a name="output_this_vswitch_id"></a> [this\_vswitch\_id](#output\_this\_vswitch\_id) | The ID of the VSwitch. |
<!-- END_TF_DOCS -->
Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/)