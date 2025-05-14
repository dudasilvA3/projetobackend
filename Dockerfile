# Etapa 1: Build (compilar o TypeScript)
FROM node:18-buster AS builder

# Instala dependências de sistema para compilar libs nativas como bcrypt
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /usr/src/app

# Copia os arquivos de dependências
COPY package*.json ./

# Instala todas as dependências (incluindo as de desenvolvimento)
RUN npm install

# Copia o restante do código
COPY . .

# Compila o TypeScript para JavaScript
RUN npm run build


# Etapa 2: Produção
FROM node:18-buster

# Define o diretório da aplicação
WORKDIR /usr/src/app

# Copia apenas os arquivos de produção
COPY package*.json ./
RUN npm install --omit=dev

# Copia os arquivos já compilados da etapa anterior
COPY --from=builder /usr/src/app/dist ./dist

# Expõe a porta da aplicação
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "dist/index.js"]
