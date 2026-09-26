variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}

variable "yc_zone" {
  type        = string
  description = "Зона доступности"
  default     = "ru-central1-a"
}

variable "sa_key_file" {
  type        = string
  description = "Путь к JSON-ключу сервисного аккаунта"
  default     = "authorized_key.json"
}

variable "access_key" {
  type        = string
  description = "Static access key ID для Object Storage"
  sensitive   = true
}

variable "secret_key" {
  type        = string
  description = "Static secret key для Object Storage"
  sensitive   = true
}

variable "bucket_name" {
  type        = string
  description = "Глобально уникальное имя бакета"
}

variable "service_account_id" {
  type        = string
  description = "ID сервисного аккаунта для Instance Group"
  default     = "ajesou5j2c76qg5e6dj6"
}

variable "lamp_image_id" {
  type        = string
  description = "ID образа LAMP"
  default     = "fd827b91d99psvq5fjit"
}

variable "vm_count" {
  type        = number
  description = "Количество ВМ в группе"
  default     = 3
}
