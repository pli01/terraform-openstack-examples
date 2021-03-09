### outputs
output "stack_output" {
  value = openstack_orchestration_stack_v1.stack_1.outputs
  depends_on = [
    openstack_orchestration_stack_v1.stack_1
  ]
}
#output "worker_fip" {
#  value = openstack_networking_floatingip_v2.worker.address
#}
