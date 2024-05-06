resource "yandex_compute_disk" "terraform1" {
  name     = "terraform1"
  type     = "network-hdd"
  zone     = var.zone
  size     = 10
  image_id = var.image_id

  labels = {
    environment = "terraform1"
  }
}

resource "yandex_vpc_address" "addr" {
  name = "vm-address"
  external_ipv4_address {
    zone_id = var.zone
  }
}

resource "yandex_compute_instance" "default" {
  name        = "terraform1"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.terraform1.id
  }

  network_interface {
    subnet_id      = "e2lhu6omt75nnfnsh4nr"
    nat            = true
    nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
  scheduling_policy {
    preemptible = true
  }
}

data "template_file" "inventory" {
  template = file("./terraform/templates/inventory.tpl")
  vars = {
    user      = "ansible"
    host_name = yandex_compute_instance.default.name
    host_addr = yandex_vpc_address.addr.external_ipv4_address[0].address
    # host = join("", [yandex_compute_instance.default.name, " ansible_host=", yandex_vpc_address.addr.external_ipv4_address[0].address])
  }
}

resource "local_file" "save_inventory" {
  content  = data.template_file.inventory.rendered
  filename = "./ansible/inventory"
}

