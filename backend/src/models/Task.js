const { query } = require('../config/database');

class Task {
  static async createTable() {
    const createTableQuery = `
      CREATE TABLE IF NOT EXISTS tasks (
        id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
        title VARCHAR(255) NOT NULL,
        description TEXT,
        status VARCHAR(50) DEFAULT 'pending',
        priority VARCHAR(50) DEFAULT 'medium',
        due_date TIMESTAMP,
        user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
      
      CREATE INDEX IF NOT EXISTS idx_tasks_user_id ON tasks(user_id);
      CREATE INDEX IF NOT EXISTS idx_tasks_status ON tasks(status);
    `;
    
    await query(createTableQuery);
  }

  static async create(taskData) {
    const { title, description, status, priority, dueDate, userId } = taskData;
    
    const insertQuery = `
      INSERT INTO tasks (title, description, status, priority, due_date, user_id)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `;
    
    const result = await query(insertQuery, [
      title, description, status, priority, dueDate, userId
    ]);
    return result.rows[0];
  }

  static async findByUserId(userId, filters = {}) {
    let whereClause = 'WHERE user_id = $1';
    const params = [userId];
    let paramCount = 1;

    if (filters.status) {
      paramCount++;
      whereClause += ` AND status = $${paramCount}`;
      params.push(filters.status);
    }

    if (filters.priority) {
      paramCount++;
      whereClause += ` AND priority = $${paramCount}`;
      params.push(filters.priority);
    }

    const queryText = `
      SELECT * FROM tasks 
      ${whereClause}
      ORDER BY created_at DESC
    `;

    const result = await query(queryText, params);
    return result.rows;
  }

  static async findByIdAndUserId(id, userId) {
    const result = await query(
      'SELECT * FROM tasks WHERE id = $1 AND user_id = $2',
      [id, userId]
    );
    return result.rows[0];
  }

  static async update(id, userId, updates) {
    const allowedFields = ['title', 'description', 'status', 'priority', 'due_date'];
    const setClause = [];
    const params = [];
    let paramCount = 0;

    Object.keys(updates).forEach(key => {
      if (allowedFields.includes(key)) {
        paramCount++;
        setClause.push(`${key} = $${paramCount}`);
        params.push(updates[key]);
      }
    });

    if (setClause.length === 0) {
      throw new Error('No valid fields to update');
    }

    paramCount++;
    setClause.push(`updated_at = $${paramCount}`);
    params.push(new Date());

    paramCount++;
    params.push(id);
    paramCount++;
    params.push(userId);

    const queryText = `
      UPDATE tasks 
      SET ${setClause.join(', ')}
      WHERE id = $${paramCount - 1} AND user_id = $${paramCount}
      RETURNING *
    `;

    const result = await query(queryText, params);
    return result.rows[0];
  }

  static async delete(id, userId) {
    const result = await query(
      'DELETE FROM tasks WHERE id = $1 AND user_id = $2 RETURNING *',
      [id, userId]
    );
    return result.rows[0];
  }
}

module.exports = Task;