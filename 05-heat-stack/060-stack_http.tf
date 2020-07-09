#### Heat CONFIGURATION ####
# create heat stack
resource "openstack_orchestration_stack_v1" "stack_1" {
  name = "stack_1"
  # override heat parameters
  parameters = {
     floatingip_network_name = var.external_network
     worker_network          = openstack_networking_network_v2.generic.id
     worker_subnet           = openstack_networking_subnet_v2.http.id
     source_volid            = openstack_blockstorage_volume_v2.root_volume.id
     worker_vol_type         = var.vol_type
     worker_flavor           = var.flavor
     worker_image            = var.image
     key_name                = var.key_name
     no_proxy                = var.no_proxy
  }
  # override heat parameters with param files
  environment_opts = {
    Bin = file("heat/worker-param.yml")
  }
  # define heat file
  template_opts = {
    Bin = file("heat/worker.yml")
  }
  disable_rollback = true
#  disable_rollback = false
  timeout = 30
}
