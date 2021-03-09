resource "openstack_networking_secgroup_v2" "web_secgroup_1" {
  name        = "web_secgroup_1"
  description = "Web security group"
  #delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "ssh_bastion_web_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.ssh_access_cidr
  security_group_id = openstack_networking_secgroup_v2.web_secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "ssh_http_web_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.network_http["cidr"]
  security_group_id = openstack_networking_secgroup_v2.web_secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "http_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web_secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "https_secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.web_secgroup_1.id
}

