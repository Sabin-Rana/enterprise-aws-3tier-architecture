# ==============================================================================
# FRONTEND DOCKERFILE - ENTERPRISE AWS 3-TIER ARCHITECTURE
# ==============================================================================
# Multi-stage Docker build for React frontend application
# Stage 1: Build the React application
# Stage 2: Serve with NGINX in production
# ==============================================================================

# Stage 1: Build environment
FROM node:16-alpine as builder

# Set working directory for build stage
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code and build production bundle
COPY . .
RUN npm run build

# Stage 2: Production environment  
FROM nginx:alpine

# Copy built application from build stage
COPY --from=builder /app/build /usr/share/nginx/html

# Copy NGINX configuration for React Router support
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for web traffic
EXPOSE 80

# Start NGINX in foreground mode
CMD ["nginx", "-g", "daemon off;"]