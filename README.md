# Домашнее задание к занятию "Безопасность в облачных провайдерах"

## Задание 1. Yandex Cloud
1) С помощью ключа в KMS необходимо зашифровать содержимое бакета:  
 - создать ключ в KMS;    
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.
2) (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:    
 - создать сертификат;    
 - создать статическую страницу в Object Storage и применить сертификат HTTPS;    
 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).    

### 1. Шифрование бакета с помощью KMS

#### 1.1. Создание ключа в KMS

![image](https://github.com/temagraf/CloudSecurity/blob/main/1-1.png)

![image](https://github.com/temagraf/CloudSecurity/blob/main/Снимок%20экрана%202025-03-06%20в%2002.12.04.png)

Файл kms.tf:
```hcl
resource "yandex_kms_symmetric_key" "key-1" {
  name              = "storage-key"
  description       = "Key for storage encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}
```

#### 1.2. Шифрование содержимого бакета

Конфигурация в файле kms.tf:

```hcl
resource "yandex_kms_symmetric_key" "key-1" {
  name              = "storage-key"
  description       = "Key for storage encryption"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}
```
### Настройка HTTPS для статического сайта

#### 2.1. Создание сертификата

Конфигурация в файле certificate.tf:
```hcl
resource "yandex_cm_certificate" "website_cert" {
  name    = "website-cert"
  domains = ["byzgaev-website-20250305.website.yandexcloud.net"]
  managed {
    challenge_type = "HTTP"
  }
}
```
![image](https://github.com/temagraf/CloudSecurity/blob/main/Снимок%20экрана%202025-03-06%20в%2002.09.50.png)

#### 2.2. Настройка статического сайта

Конфигурация в файле storage.tf:
```hcl
resource "yandex_storage_bucket" "website" {
  bucket = "byzgaev-website-20250305"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  https {
    certificate_id = yandex_cm_certificate.website_cert.id
  }
}
```

#### 2.3. Проверка работы HTTPS  

Сертификат успешно выпущен:  
Статус: ISSUED  
Издатель: Let's Encrypt  
Срок действия: до 04.06.2025  

![image](https://github.com/temagraf/CloudSecurity/blob/main/Снимок%20экрСоздан%20и%20настроен%20ключ%20ана%202025-03-06%20в%2004.11.24.png)

![image](https://github.com/temagraf/CloudSecurity/blob/main/2-3%20статус%20сертификата.png)

#### Результаты  
Созданная инфраструктура:

Зашифрованный бакет с KMS ключом  
Статический сайт с HTTPS  
Валидный SSL-сертификат от Let's Encrypt  
Безопасный доступ к контенту  



![image](https://github.com/temagraf/CloudSecurity/blob/main/Симетричные%20клучи.png)

![image](https://github.com/temagraf/CloudSecurity/blob/main/Настроен%20HTTPS.png)

![image](https://github.com/temagraf/CloudSecurity/blob/main/Снимок%20экрана%202025-03-06%20в%2003.56.09.png)
