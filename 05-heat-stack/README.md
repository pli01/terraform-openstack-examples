# How to

![infra instance with volume](../img/02-instance-with-volume.png "infra instance with volume")

### Create stack

```
terraform apply
```

This script will create:
-   1 router
-   1 network
-   1 volume from image
-   1 stack with 1 instance with attached volume, and user_data with waitcondition

### delete stack

```
terraform destroy
```

### in case of error
import failed stack then destroy
```
openstack stack list
terraform import "openstack_orchestration_stack_v1.stack_1" _STACK_UUID_TO_IMPORT_
terraform destroy --target=openstack_orchestration_stack_v1.stack_1
```
