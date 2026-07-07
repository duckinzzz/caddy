#!/bin/bash
# Скрипт для обновления Caddy на сервере
# Использование: ./deploy.sh [GITHUB_TOKEN]

set -e

if [ -z "$1" ]; then
    echo "Использование: ./deploy.sh <GITHUB_TOKEN>"
    echo ""
    echo "Токен нужен только для первого запуска (docker login)."
    echo "Создай Personal Access Token (classic) с правами read:packages:"
    echo "  https://github.com/settings/tokens"
    exit 1
fi

GITHUB_TOKEN="$1"

# Логинимся в GHCR (если ещё не залогинены)
echo "🔐 Логин в GitHub Container Registry..."
echo "$GITHUB_TOKEN" | docker login ghcr.io -u YOUR_GITHUB_USERNAME --password-stdin

# Тянем свежий образ
echo "📥 Загрузка нового образа..."
docker compose pull

# Перезапускаем
echo "🔄 Перезапуск Caddy..."
docker compose up -d --remove-orphans

echo "✅ Готово! Проверь: docker compose ps"
