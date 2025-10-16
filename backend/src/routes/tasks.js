const express = require('express');
const { body, param, validationResult } = require('express-validator');
const Task = require('../models/Task');
const auth = require('../middleware/auth');
const logger = require('../utils/logger');

const router = express.Router();

// Initialize database tables
router.use(async (req, res, next) => {
  try {
    await Task.createTable();
    next();
  } catch (error) {
    next(error);
  }
});

// Get all tasks for user
router.get('/', auth, async (req, res, next) => {
  try {
    const { status, priority } = req.query;
    const filters = {};
    
    if (status) filters.status = status;
    if (priority) filters.priority = priority;

    const tasks = await Task.findByUserId(req.user.userId, filters);
    
    res.json({
      tasks,
      count: tasks.length
    });
  } catch (error) {
    next(error);
  }
});

// Get single task
router.get('/:id', [
  auth,
  param('id').isUUID()
], async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const task = await Task.findByIdAndUserId(req.params.id, req.user.userId);
    if (!task) {
      return res.status(404).json({ error: 'Task not found' });
    }

    res.json({ task });
  } catch (error) {
    next(error);
  }
});

// Create new task
router.post('/', [
  auth,
  body('title').notEmpty().trim().isLength({ max: 255 }),
  body('description').optional().trim(),
  body('status').optional().isIn(['pending', 'in-progress', 'completed']),
  body('priority').optional().isIn(['low', 'medium', 'high']),
  body('dueDate').optional().isISO8601()
], async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const taskData = {
      ...req.body,
      userId: req.user.userId
    };

    const task = await Task.create(taskData);
    
    logger.info(`Task created: ${task.id} for user: ${req.user.userId}`);
    
    res.status(201).json({
      message: 'Task created successfully',
      task
    });
  } catch (error) {
    next(error);
  }
});

// Update task
router.put('/:id', [
  auth,
  param('id').isUUID(),
  body('title').optional().trim().isLength({ max: 255 }),
  body('description').optional().trim(),
  body('status').optional().isIn(['pending', 'in-progress', 'completed']),
  body('priority').optional().isIn(['low', 'medium', 'high']),
  body('dueDate').optional().isISO8601()
], async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const task = await Task.update(req.params.id, req.user.userId, req.body);
    if (!task) {
      return res.status(404).json({ error: 'Task not found' });
    }

    logger.info(`Task updated: ${task.id} for user: ${req.user.userId}`);

    res.json({
      message: 'Task updated successfully',
      task
    });
  } catch (error) {
    next(error);
  }
});

// Delete task
router.delete('/:id', [
  auth,
  param('id').isUUID()
], async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const task = await Task.delete(req.params.id, req.user.userId);
    if (!task) {
      return res.status(404).json({ error: 'Task not found' });
    }

    logger.info(`Task deleted: ${task.id} for user: ${req.user.userId}`);

    res.json({
      message: 'Task deleted successfully',
      task
    });
  } catch (error) {
    next(error);
  }
});

module.exports = router;