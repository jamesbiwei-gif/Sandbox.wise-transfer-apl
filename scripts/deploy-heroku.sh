#!/bin/bash

# Heroku Deployment Quick Start
# This script quickly deploys to Heroku

set -e

echo "🚀 Heroku Quick Start Deployment"
echo ""

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI is not installed"
    echo "   Install from: https://devcenter.heroku.com/articles/heroku-cli"
    echo ""
    echo "   macOS: brew tap heroku/brew && brew install heroku"
    echo "   Windows: Download from https://cli-assets.heroku.com/heroku-x64.exe"
    echo "   Linux: curl https://cli-assets.heroku.com/install.sh | sh"
    exit 1
fi

echo "✅ Heroku CLI found"
echo ""

# Check if logged in
if ! heroku auth:whoami &> /dev/null; then
    echo "🔐 You are not logged in to Heroku"
    echo "   Run: heroku login"
    exit 1
fi

echo "✅ Logged in to Heroku"
echo ""

# Get app name
read -p "Enter Heroku app name (or press Enter to create new): " APP_NAME

if [ -z "$APP_NAME" ]; then
    echo "📝 Creating new Heroku app..."
    heroku create
else
    echo "📝 Using app: $APP_NAME"
fi

echo ""
echo "🔑 Setting environment variables..."

read -p "Enter WISE_API_KEY: " API_KEY
heroku config:set WISE_API_KEY=$API_KEY

heroku config:set WISE_API_BASE_URL=https://api.sandbox.transferwise.tech
heroku config:set NODE_ENV=production

echo "✅ Environment variables set"
echo ""

echo "🚀 Deploying to Heroku..."
git push heroku main

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📍 Your app is live at:"
heroku apps:info -s | grep web_url
echo ""
echo "📊 Useful commands:"
echo "   heroku logs -t              # View logs in real-time"
echo "   heroku open                 # Open app in browser"
echo "   heroku ps                   # View running dynos"
echo "   heroku config               # View environment variables"
