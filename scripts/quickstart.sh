#!/bin/bash

# Quick Start Guide for Local Deployment
# This script sets up and runs the Wise Transfer API Demo locally

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   Wise Transfer API Demo - Local Docker Deployment        ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first:"
    echo "   https://docs.docker.com/get-docker/"
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install it first:"
    echo "   https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker is installed"
echo "✅ Docker Compose is installed"
echo ""

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please edit .env and add your WISE_API_KEY"
    echo ""
    echo "   nano .env"
    echo ""
    read -p "Press Enter when you've added your API key..."
fi

# Check if WISE_API_KEY is set
if grep -q "your_api_key_here" .env; then
    echo "❌ Error: WISE_API_KEY is still set to placeholder value"
    echo "   Please edit .env and add your actual Wise Transfer API key"
    echo ""
    echo "   nano .env"
    exit 1
fi

echo "🐳 Building Docker image..."
docker-compose build

echo ""
echo "🚀 Starting application with Docker Compose..."
docker-compose up -d

echo ""
echo "⏳ Waiting for application to start..."
sleep 5

# Check if container is running
if docker-compose ps | grep -q "wise-transfer-demo"; then
    echo "✅ Application is running!"
    echo ""
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║               🎉 DEPLOYMENT SUCCESSFUL 🎉                  ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    echo "📍 Access Points:"
    echo "   • Application: http://localhost:3000"
    echo "   • Container: wise-transfer-demo"
    echo ""
    echo "📊 Useful Commands:"
    echo "   • View logs:     docker-compose logs -f wise-transfer-demo"
    echo "   • Stop:          docker-compose down"
    echo "   • Restart:       docker-compose restart"
    echo "   • Shell access:  docker-compose exec wise-transfer-demo sh"
    echo ""
    echo "🧪 Test the API:"
    echo "   curl http://localhost:3000"
    echo ""
else
    echo "❌ Failed to start application"
    echo "   View logs: docker-compose logs"
    exit 1
fi
