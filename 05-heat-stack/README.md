# How to

![infra heat stack instance with volume](../img/05-heat-stack.png "infra heat stack instance with volume")

- This sample create with terraform the following architecture:
- Create router/network/volume and heat stack resources
- heat stack create an instance with root volume attached, and execute user_data at boot time.
  Waitcondition in heat allow to trigger orchestration service and inform about the status of the stack (succes or failure)

### Create stack

To use the openstack provider without storing your credentials, source your OS environment variables, before running terraform command
```
source my-openstack-creds.rc
```
Run terraform
```
terraform plan
terraform apply
```

A simple Makefile can be used to shortened tf command: make plan, deploy...

This tf script will create:
-   1 router
-   1 network
-   1 root volume from image
-   1 stack with 1 instance with attached volume, and user_data with waitcondition

The waitcondition allow to wait the end of all cloud-init executed command on instance before given the signal end to terraform


### delete stack

```
terraform destroy
```

### In case of stack creation error
import the failed stack then destroy it

```
# get stack id
openstack stack list
# import stack in terraform
terraform import "openstack_orchestration_stack_v1.stack_1" _STACK_UUID_TO_IMPORT_
# destroy
terraform destroy --target=openstack_orchestration_stack_v1.stack_1
```
