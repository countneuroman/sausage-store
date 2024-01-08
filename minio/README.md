## Как синхронизировать Yandex Object Stroage с локальным Minio:

1. Создать пользователя с правами readWrite на ваш bucket в Minio
2. Создать для этого пользователя AccesKey
3. Создать сервисный аккаунт с правами readWrite для Yandex Object Stroage
4. Сделать acces key для сервисного аккаунта
5. Установить rclone
5. Указать данные ключей в rclone.conf (пример в текущей папке)
6. Запустить команду rclone sync yandex:bucket_name minio:bucket_name
7. По желанию через crontab добавить джобу для запуска синхронизации по времени
