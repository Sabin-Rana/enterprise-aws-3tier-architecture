# Enterprise Backend API

Production-ready Node.js backend for AWS 3-Tier Architecture.

## Features

- **RESTful API** with Express.js
- **PostgreSQL** database integration
- **JWT Authentication** with secure password hashing
- **Task Management** with CRUD operations
- **Security** with Helmet, CORS, Rate Limiting
- **Logging** with Winston
- **Docker** containerization ready
- **PM2** process management

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Set up environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials
   ```

3. **Run in development:**
   ```bash
   npm run dev
   ```

4. **Run in production:**
   ```bash
   npm start
   ```

## API Endpoints

- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `GET /api/auth/profile` - Get user profile
- `GET /api/tasks` - Get user tasks
- `POST /api/tasks` - Create new task
- `PUT /api/tasks/:id` - Update task
- `DELETE /api/tasks/:id` - Delete task

## Deployment

### Docker

```bash
docker build -t enterprise-backend .
docker run -p 4000:4000 enterprise-backend
```

### PM2

```bash
npm install -g pm2
pm2 start ecosystem.config.js
```

## Environment Variables

See `.env.example` for all required environment variables.