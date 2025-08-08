# Создаем KMS ключ
resource "yandex_kms_symmetric_key" "key-1" {
  name              = "storage-key"
  description       = "Key for storage encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}
