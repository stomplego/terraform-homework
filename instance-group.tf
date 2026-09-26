# Используем существующую сеть и подсеть (квота на создание новых исчерпана)
data "yandex_vpc_network" "existing_net" {
  network_id = "enpuqmi9m3ttqutji1rh"
}

data "yandex_vpc_subnet" "existing_subnet" {
  subnet_id = "e9bja4qm103nbu3v44hj"
}

locals {
  image_url = "https://${yandex_storage_bucket.hw_bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.picture.key}"
}

resource "yandex_compute_instance_group" "lamp_group" {
  name               = "lamp-group"
  folder_id          = var.yc_folder_id
  service_account_id = var.service_account_id

  instance_template {
    platform_id = "standard-v3"

    resources {
      cores  = 2
      memory = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = var.lamp_image_id
        size     = 10
      }
    }

    network_interface {
      network_id = data.yandex_vpc_network.existing_net.id
      subnet_ids = [data.yandex_vpc_subnet.existing_subnet.id]
      nat        = true
    }

    metadata = {
      user-data = <<-EOT
        #cloud-config
        write_files:
          - path: /var/www/html/index.html
            content: |
              <!DOCTYPE html>
              <html lang="ru">
              <head>
                <meta charset="UTF-8">
                <title>Terraform Homework</title>
              </head>
              <body>
                <h1>Привет из Yandex Cloud!</h1>
                <p>Эта страница создана через Terraform + cloud-init.</p>
                <img src="${local.image_url}" alt="Picture from bucket" width="600">
              </body>
              </html>
            permissions: '0644'
        runcmd:
          - systemctl restart apache2
      EOT
    }
  }

  scale_policy {
    fixed_scale {
      size = var.vm_count
    }
  }

  allocation_policy {
    zones = [var.yc_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 1
  }

  load_balancer {
    target_group_name = "lamp-target-group"
  }

  health_check {
    timeout             = 10
    interval            = 15
    healthy_threshold   = 2
    unhealthy_threshold = 3
    http_options {
      port = 80
      path = "/"
    }
  }

  depends_on = [
    yandex_storage_object.picture,
  ]
}
