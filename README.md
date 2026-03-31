# Meu Primeiro Rails API

## API Ruby on Rails com PostgreSQL

## Ruby version

- Ruby 3.3+

---

## System dependencies

### Local

- Ruby 3.3+
- Bundler
- PostgreSQL 17
- libyaml

### Docker

- Docker
- Docker Compose

---

## Configuration

Copie o arquivo de exemplo de variáveis de ambiente:

```bash
cp .env.example .env
```

No Windows:

```bat
copy .env.example .env
```

Edite o `.env` conforme necessário.

---

## Database creation

```bash
rails db:create
```

---

## Database initialization

```bash
rails db:migrate
```

---

## How to run the application (local)

```bash
bundle install
rails db:create
rails db:migrate
rails s
```

Acesse:

http://localhost:3000

---

## Running with Docker Compose

```bash
docker compose up --build -d
docker compose exec web bash

rails db:create
rails db:migrate
```

### Run the application (docker)

```bash
rails s -b 0.0.0.0
```

Acesse:

http://localhost:3000

---

## Deployment instructions

- Configurar variáveis de ambiente (ENV)
- Configurar banco de produção
- Rodar migrations:

```bash
rails db:migrate RAILS_ENV=production
```

---

## Notes

- Local usa `localhost` como host do banco
- Docker usa `db` como host
- Use variáveis de ambiente no `database.yml`
