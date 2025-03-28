#!/bin/sh

sleep 20

echo "🔄 Восстанавливаем базу данных..."

mysql -h 127.0.0.1 -u root -prootpassword ecommerce < /docker-entrypoint-initdb.d/db-backup.sql

# Создаем флаг, чтобы больше не выполнять восстановление
touch "$FLAG_FILE"

echo "✅ Восстановление завершено!"
