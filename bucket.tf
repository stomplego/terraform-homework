resource "yandex_storage_bucket" "hw_bucket" {
  bucket     = var.bucket_name
  access_key = var.access_key
  secret_key = var.secret_key

  anonymous_access_flags {
    read = true
    list = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
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

resource "yandex_storage_bucket" "site_bucket" {
  bucket     = "stomple-site-20260926"
  access_key = var.access_key
  secret_key = var.secret_key

  anonymous_access_flags {
    read = true
    list = false
  }

  website {
    index_document = "index.html"
  }
}

resource "yandex_storage_object" "index" {
  bucket       = yandex_storage_bucket.site_bucket.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text/html"
  access_key   = var.access_key
  secret_key   = var.secret_key

  depends_on = [yandex_storage_bucket.site_bucket]
}
