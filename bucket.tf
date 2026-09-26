resource "yandex_storage_bucket" "hw_bucket" {
  bucket     = var.bucket_name
  access_key = var.access_key
  secret_key = var.secret_key

  anonymous_access_flags {
    read = true
    list = false
  }
}

resource "yandex_storage_object" "picture" {
  bucket       = yandex_storage_bucket.hw_bucket.id
  key          = "picture.jpg"
  source       = "picture.jpg"
  content_type = "image/jpeg"
  access_key   = var.access_key
  secret_key   = var.secret_key

  depends_on = [yandex_storage_bucket.hw_bucket]
}
