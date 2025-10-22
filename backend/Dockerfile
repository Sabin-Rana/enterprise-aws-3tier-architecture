# ==============================================================================
# BACKEND DOCKERFILE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# Multi-stage Docker build for Node.js backend API
# Stage 1: Builder - Install dependencies and prepare build
# Stage 2: Production - Optimized runtime with security best practices
# ==============================================================================

# Stage 1: Builder environment
FROM node:16-alpine AS builder

# Set working directory for build stage
WORKDIR /app

# Copy package files first for better Docker layer caching
COPY package*.json ./
COPY .env.example ./

# Install all dependencies including development packages
RUN npm ci && npm cache clean --force

# Copy application source code
COPY . .

# Stage 2: Production environment
FROM node:16-alpine AS production

# Install security updates and create non-root user for security
RUN apk update && apk upgrade && \
    addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Set working directory for production
WORKDIR /app

# Copy package files and production node_modules from builder stage
COPY --from=builder --chown=nodejs:nodejs /app/package*.json ./
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules

# Copy application source code with proper ownership
COPY --chown=nodejs:nodejs . .

# Create logs directory for PM2 process manager
RUN mkdir -p logs && chown nodejs:nodejs logs

# Switch to non-root user for enhanced security
USER nodejs

# Expose application port (matches server.js configuration)
EXPOSE 4000

# Set production environment variables
ENV NODE_ENV=production
ENV PORT=4000

# Health check for container orchestration
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:4000/health || exit 1

# Start application with PM2 process manager for production
CMD ["npx", "pm2-runtime", "start", "ecosystem.config.js", "--env", "production"]