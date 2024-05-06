# output "external_ip" {
#   value = "${yandex_compute_instance.default.network_interface.0.access_config.0.assigned_nat_ip}"
# }
output "external_ip" {
  value = yandex_compute_instance.default.network_interface.0.nat_ip_address
}
output "internal_ip" {
  value = yandex_compute_instance.default.network_interface.0.ip_address
}


