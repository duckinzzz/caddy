# caddy

Общий reverse-proxy для сервисов на хосте: Caddy + caddy-docker-proxy.

Маршруты в конфиге не прописываются: контейнеры описывают себя лейблами.

```yaml
labels:
  caddy: app.example.com
  caddy.reverse_proxy: "{{upstreams 80}}"
```

## Запуск

```bash
docker network create caddy-proxy
cp .env.example .env      # CF_API_TOKEN, CADDY_EMAIL
docker compose up -d
```

Образ собирается через `xcaddy`: в официальном нет ни docker-proxy, ни
DNS-провайдера Cloudflare, а DNS-челлендж нужен для wildcard-сертификатов.
Push в master собирает образ в GHCR и раскатывает на сервере, где `/srv/caddy`
это git-клон репозитория. `.env` в git не лежит и раскаткой не затирается.
