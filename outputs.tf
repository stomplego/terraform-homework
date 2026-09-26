output "image_url" {
  description = "Публичный URL картинки в бакете"
  value       = local.image_url
}

output "bucket_name" {
  description = "Имя бакета"
  value       = yandex_storage_bucket.hw_bucket.bucket
}

output "nlb_ip" {
  description = "IP-адрес сетевого балансировщика"
  value       = tolist(tolist(yandex_lb_network_load_balancer.hw_nlb.listener)[0].external_address_spec)[0].address
}
