#### Heat CONFIGURATION ####
# create heat stack
resource "openstack_orchestration_stack_v1" "stack_1" {
  name = "stack_1"
  # override heat parameters
  parameters = {
    floating_ip_id          = openstack_networking_floatingip_v2.worker.id
    security_group          = openstack_networking_secgroup_v2.web_secgroup_1.id
    worker_network          = openstack_networking_network_v2.generic.id
    worker_subnet           = openstack_networking_subnet_v2.http.id
    source_volid            = openstack_blockstorage_volume_v2.root_volume.id
    worker_vol_type         = var.vol_type
    worker_flavor           = var.flavor
    worker_image            = var.image
    key_name                = var.key_name
    no_proxy                = var.no_proxy
    ssh_access_cidr         = var.ssh_access_cidr
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
