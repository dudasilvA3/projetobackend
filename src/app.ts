// src/app.ts
import express from 'express';
import dotenv from 'dotenv';

dotenv.config();

const app = express();

app.use(express.json());

// Rota de teste
app.get('/', (_req, res) => {
  res.send('🚀 API funcionando!');
});

export default app;
