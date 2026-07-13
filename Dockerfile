FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Expose port (if running a server)
EXPOSE 3000

# Default command
CMD ["npm", "run", "dev"]
