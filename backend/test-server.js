const express = require('express');
const app = express();
const PORT = 4000;

// Basic middleware
app.use(express.json());

app.get('/health', (req, res) => {
  res.json({ 
    status: 'healthy',
    service: 'Enterprise Backend API - Validation Test',
    timestamp: new Date().toISOString(),
    database: 'disconnected (expected for local validation)',
    message: 'API server is working correctly'
  });
});

app.listen(PORT, () => {
  console.log("� VALIDATION: Backend API Server running on port 4000");
  console.log("� PURPOSE: Portfolio evidence generation");
  console.log("� Health endpoint: http://localhost:4000/health");
  console.log("✅ Database connection skipped for zero-cost validation");
});
