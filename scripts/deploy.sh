#!/bin/bash

# Deploy script for Wise Transfer API Demo
# This script handles deployment to various environments

set -e

ENVIRONMENT=${1:-development}
VERSION=$(grep '"version"' package.json | head -1 | awk -F'"' '{print $4}')

echo "🚀 Deploying Wise Transfer API Demo"
echo "📍 Environment: $ENVIRONMENT"
echo "📦 Version: $VERSION"
echo ""

# Check environment
if [ ! -f ".env.$ENVIRONMENT" ]; then
  echo "⚠️  Warning: .env.$ENVIRONMENT not found"
  echo "📄 Creating .env.$ENVIRONMENT from .env.example"
  cp .env.example .env.$ENVIRONMENT 2>/dev/null || echo "⚠️  .env.example not found"
fi

# Load environment variables
export $(cat .env.$ENVIRONMENT | xargs)

# Build the application
echo "🔨 Building application..."
npm run build

# Run tests
echo "🧪 Running tests..."
npm test

# Docker build
echo "🐳 Building Docker image..."
docker build -t wise-transfer-demo:$VERSION .
docker tag wise-transfer-demo:$VERSION wise-transfer-demo:latest

echo ""
echo "✅ Deployment preparation completed!"
echo ""
echo "📦 Docker Images:"
echo "   - wise-transfer-demo:$VERSION"
echo "   - wise-transfer-demo:latest"
echo ""
echo "🚀 Deploy with:"
echo "   - docker run -e WISE_API_KEY=\$WISE_API_KEY wise-transfer-demo:$VERSION"
echo "   - docker-compose up -d"
