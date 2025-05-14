# Projeto Backend Boilerplate

Este é um boilerplate para um projeto backend utilizando **Node.js**, **TypeScript**, **PostgreSQL** e **Docker**.

## Estrutura do projeto

A estrutura do projeto é a seguinte:

```
/projeto
├── src
│   ├── app.ts
│   ├── config
│   ├── controllers
│   ├── database
│   ├── models
│   ├── routes
│   ├── services
│   ├── middlewares
│   ├── utils
│   └── tests
├── .env
├── .env.dev
├── .env.test
├── docker-compose.yml
├── docker-compose.dev.yml
├── docker-compose.test.yml
├── package.json
├── tsconfig.json
├── tsconfig.build.json
└── jest.config.js
```

## Como rodar o projeto

### Docker
Este projeto usa Docker para rodar tanto no ambiente de desenvolvimento quanto em produção.

### Produção
Para rodar o ambiente de produção, use o comando:
```
docker-compose -f docker-compose.yml up --build
```

### Desenvolvimento
Para rodar o ambiente de desenvolvimento, use o comando:
```
docker-compose -f docker-compose.dev.yml up --build
```

### Testes
Para rodar os testes, use o comando:
```
docker-compose -f docker-compose.test.yml up --build
```

## Variáveis de ambiente

As variáveis de ambiente podem ser configuradas nos arquivos ,  e .

Seu `docker-compose.dev.yml` está quase pronto para funcionar no modo de desenvolvimento. Faltam só alguns pequenos ajustes para garantir que ele funcione corretamente com **`ts-node-dev`**, e para evitar erros como o de sobrescrever o `node_modules`.

---

### ✅ Passos finais:

#### 1. **Instale `ts-node-dev`**:

Dentro do seu projeto (no WSL):

```bash
npm install --save-dev ts-node-dev

```

---

#### 2. **Atualize seu `package.json` com o script `dev`**:

```json
"scripts": {
  "dev": "ts-node-dev --respawn --transpile-only src/app.ts",
  "build": "tsc -p tsconfig.build.json",
  "start": "node dist/index.js"
}
```

> Certifique-se de que seu arquivo principal está em `src/app.ts`.

---

#### 3. **Corrija o volume do `node_modules` no Compose** (muito importante):

Atualize a parte do volume do `app` no seu `docker-compose.dev.yml` para:

```yaml
volumes:
  - .:/app
  - /app/node_modules
```

> Isso impede que o `node_modules` do seu container seja sobrescrito pelo volume do host (se ele não existir no host ainda).

---

### ✅ Arquivo final do `docker-compose.dev.yml`:

```yaml
version: '3'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    env_file:
      - .env.dev
    volumes:
      - .:/app
      - /app/node_modules
    networks:
      - backend
    command: npm run dev

  db:
    image: postgres:13
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: db_dev
    volumes:
      - postgres_data:/var/lib/postgresql/data
    networks:
      - backend

networks:
  backend:

volumes:
  postgres_data:
```

---

### ✅ Para rodar:

```bash
docker-compose -f docker-compose.dev.yml up --build
```

Isso vai iniciar seu backend em modo **hot-reload**. Agora é só editar os arquivos `.ts` e ver o resultado imediatamente sem rebuildar o container.

Deseja que eu revise seu `app.ts` para garantir que o Express esteja iniciando corretamente?
