#### INSTANCE HTTP ####

# Get the uuid of image
data "openstack_images_image_v2" "debian_current" {
  name        = var.image
  most_recent = true
}

resource "openstack_blockstorage_volume_v2" "http_volume" {
  name        = "http-volume"
  size        = var.volume_http
  volume_type = var.volume_type
  image_id    = data.openstack_images_image_v2.debian_current.id
}
# Create instance
#
resource "openstack_compute_instance_v2" "http" {
  name        = "http-instance"
  flavor_name = var.flavor_http
  key_pair    = data.openstack_compute_keypair_v2.user_key.name
  user_data   = file("scripts/first-boot.sh")
  network {
    port = openstack_networking_port_v2.http.id
  }

  # Install system in volume
  block_device {
    volume_size           = var.volume_http
    destination_type      = "volume"
    delete_on_termination = false
    source_type           = "volume"
    uuid                  = openstack_blockstorage_volume_v2.http_volume.id
    boot_index            = 0
  }
}

# Create network port
resource "openstack_networking_port_v2" "http" {
  name           = "port-instance-http"
  network_id     = openstack_networking_network_v2.generic.id
  admin_state_up = true
  security_group_ids = [
    openstack_compute_secgroup_v2.ssh.id,
    openstack_compute_secgroup_v2.http.id,
  ]
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.http.id
  }
}

# Create floating ip
resource "openstack_networking_floatingip_v2" "http" {
  pool = var.external_network
}

# Attach floating ip to instance
resource "openstack_compute_floatingip_associate_v2" "http" {
  floating_ip = openstack_networking_floatingip_v2.http.address
  instance_id = openstack_compute_instance_v2.http.id
}

