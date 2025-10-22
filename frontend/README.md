# Enterprise Frontend

Production-ready React frontend for AWS 3-Tier Architecture.

## Features

- **Modern React** with hooks and functional components
- **Styled Components** for CSS-in-JS styling
- **React Router** for client-side routing
- **React Query** for server state management
- **Authentication** with JWT tokens
- **Responsive Design** for all devices
- **Task Management** with CRUD operations

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Set up environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your API URL
   ```

3. **Run in development:**
   ```bash
   npm start
   ```

4. **Build for production:**
   ```bash
   npm run build
   ```

## Environment Variables

- `REACT_APP_API_URL` - Backend API URL (default: http://localhost:4000/api)

## Deployment

### Docker

```bash
docker build -t enterprise-frontend .
docker run -p 80:80 enterprise-frontend
```

### S3 + CloudFront

```bash
npm run build
aws s3 sync build/ s3://your-bucket
```