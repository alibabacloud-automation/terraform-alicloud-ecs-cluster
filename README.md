Terraform module which creates ECS cluster on Alibaba Cloud
terraform-alicloud-ecs-cluster
=====================================================================

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

Checking
--------
    
Open Web browser and input the `web_url`(<public_ip/welcome.html>), you can get the follow result:

![image](https://github.com/aliyun/terraform-alicloud-classic-load-balance/blob/master/welcome.png)

Terraform version
-----------------
Terraform version 0.12.0+ is required for this module to work.

Authors
-------
Created and maintained by He Guimin(@xiaozhu36, heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/)

