# Create floating ip
resource "openstack_networking_floatingip_v2" "worker" {
  pool = var.external_network
}

