import { Pool } from 'pg';

const pool = new Pool({
  user: process.env.DB_USER || 'seu_usuario',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'cantina',
  password: process.env.DB_PASSWORD || 'sua_senha',
  port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 5432,
});

export const query = (text: string, params?: any[]) => pool.query(text, params);

export default pool;