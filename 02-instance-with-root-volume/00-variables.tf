# Params file for variables

#### GLANCE
variable "image" {
  type    = string
  default = "debian-latest"
}

#### NEUTRON
variable "external_network" {
  type    = string
  default = "external-network"
}

variable "dns_ip" {
  type    = list(string)
  default = ["8.8.8.8", "8.8.8.4"]
}

#### VM HTTP parameters ####
variable "flavor_http" {
  type    = string
  default = "t2.medium"
}

variable "network_http" {
  type    = map(string)
  default = {
    subnet_name = "subnet-http"
    cidr        = "192.168.1.0/24"
  }
}

#### MAIN DISK SIZE FOR HTTP
variable "volume_http" {
  type    = number
  default = 10
}

variable "volume_type" {
  type    = string
  default = "default"
}
