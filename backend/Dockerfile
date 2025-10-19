# Backend Dockerfile - Node.js API Production Container
# Multi-stage build for optimized production image

# Stage 1: Builder - Install dependencies and build
FROM node:16-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files first (for better caching)
COPY package*.json ./
COPY .env.example ./

# Install ALL dependencies (including dev for build)
RUN npm ci && npm cache clean --force

# Copy source code
COPY . .

# Stage 2: Production - Minimal runtime image
FROM node:16-alpine AS production

# Install security updates and create non-root user
RUN apk update && apk upgrade && \
    addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set working directory
WORKDIR /app

# Copy package files and production node_modules from builder
COPY --from=builder --chown=nodejs:nodejs /app/package*.json ./
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy application source code
COPY --chown=nodejs:nodejs . .

# Create logs directory for PM2
RUN mkdir -p logs && chown nodejs:nodejs logs

# Switch to non-root user
USER nodejs

# Expose application port (matches your server.js PORT 4000)
EXPOSE 4000

# Environment variables
ENV NODE_ENV=production
ENV PORT=4000

# Health check (matches your /health endpoint)
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

# Start application with PM2 process manager (matches your ecosystem.config.js)
CMD ["npx", "pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]