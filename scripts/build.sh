#!/bin/bash

# Build script for Wise Transfer API Demo
# Usage: ./scripts/build.sh

set -e

echo "🔨 Building Wise Transfer API Demo..."

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
  echo "📦 Installing dependencies..."
  npm install
fi

# Run TypeScript compilation
echo "⚙️  Compiling TypeScript..."
npm run build

# Run tests
echo "🧪 Running tests..."
npm test

echo "✅ Build completed successfully!"
echo ""
echo "📦 Artifacts:"
echo "   - dist/ - Compiled JavaScript files"
echo ""
echo "🚀 Next steps:"
echo "   - npm run dev - Start development server"
echo "   - docker build -t wise-transfer-demo . - Build Docker image"
echo "   - docker-compose up - Run with Docker Compose"
