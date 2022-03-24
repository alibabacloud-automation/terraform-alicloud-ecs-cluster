Terraform module which creates ECS cluster on Alibaba Cloud
terraform-alicloud-ecs-cluster

A terraform module to provide classic load balance architecture in alibaba cloud.

![image](https://github.com/terraform-alicloud-modules/terraform-alicloud-ecs-cluster/blob/master/architecture.png)

These types of the module resource are supported:

- [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
- [Subnet](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
- [ECS Instance](https://www.terraform.io/docs/providers/alicloud/r/instance.html)
- [Security Group](https://www.terraform.io/docs/providers/alicloud/r/security_group.html)
- [Nat Gateway](https://www.terraform.io/docs/providers/alicloud/r/nat_gateway.html)
- [SNAT](https://www.terraform.io/docs/providers/alicloud/r/snat.html)
- [DNAT](https://www.terraform.io/docs/providers/alicloud/r/forward_entry.html)
- [EIP](https://www.terraform.io/docs/providers/alicloud/r/eip.html)


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

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/)