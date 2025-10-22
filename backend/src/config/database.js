const { Pool } = require('pg');
const logger = require('../utils/logger');

const pool = new Pool({
  host: process.env.DB_HOST || 'localhost',
  port: process.env.DB_PORT || 5432,
  database: process.env.DB_NAME || 'appdb',
  user: process.env.DB_USER || 'admin',
  password: process.env.DB_PASSWORD,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

const connectDB = async () => {
  try {
    const client = await pool.connect();
    logger.info('✅ Database connected successfully');
    
    // Test query
    const result = await client.query('SELECT NOW()');
    logger.info(`📊 Database time: ${result.rows[0].now}`);
    
    client.release();
  } catch (error) {
    logger.error('❌ Database connection failed:', error);
    process.exit(1);
  }
};

const query = (text, params) => {
  return pool.query(text, params);
};

module.exports = {
  connectDB,
  query,
  pool
};