# Define ssh to config in instance
data "openstack_compute_keypair_v2" "user_key" {
  name = "debian"
}
