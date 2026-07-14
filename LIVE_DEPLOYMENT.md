# Live Deployment Guide - Wise Transfer API Demo

This guide covers deploying your Wise Transfer API Demo to live production servers.

## 🌐 Deployment Platforms Comparison

| Platform | Cost | Setup Time | Scalability | Best For |
|----------|------|-----------|-------------|----------|
| **Heroku** | $7-50/month | 5 minutes | Good | Quick prototypes, hobby projects |
| **Railway** | $5-100/month | 3 minutes | Excellent | GitHub integration, startups |
| **AWS ECS** | $10-500/month | 30 minutes | Excellent | Enterprise, high traffic |
| **Render** | $0-100/month | 5 minutes | Good | Simple apps, free tier available |
| **DigitalOcean** | $5-100/month | 10 minutes | Excellent | Developers, managed services |

---

## 🚀 Option 1: Heroku (Easiest - Recommended for Beginners)

### Prerequisites
- GitHub account
- Heroku account (free signup at https://heroku.com)
- Heroku CLI installed

### Installation

```bash
# Install Heroku CLI
brew tap heroku/brew && brew install heroku

# Or on Windows/Linux
# Visit: https://devcenter.heroku.com/articles/heroku-cli
```

### Deployment Steps

#### Step 1: Create Heroku App

```bash
# Login to Heroku
heroku login

# Create app
heroku create wise-transfer-demo
# Or with custom name
heroku create your-custom-name
```

#### Step 2: Set Environment Variables

```bash
heroku config:set WISE_API_KEY=your_sandbox_api_key
heroku config:set WISE_API_BASE_URL=https://api.sandbox.transferwise.tech
heroku config:set NODE_ENV=production
```

#### Step 3: Deploy from GitHub

**Option A: Automatic (Recommended)**

1. Login to [Heroku Dashboard](https://dashboard.heroku.com)
2. Select your app
3. Go to **Deploy** tab
4. Connect to GitHub repository
5. Enable **Automatic Deploys**

**Option B: Manual Push**

```bash
git push heroku main
```

#### Step 4: Verify Deployment

```bash
# View logs
heroku logs -t

# Open app in browser
heroku open

# Check status
heroku ps
```

#### Step 5: Add Custom Domain (Optional)

```bash
# Add domain
heroku domains:add yourdomain.com

# Set up DNS
# Follow Heroku's instructions for your domain provider
```

### Heroku Monitoring

```bash
# View logs
heroku logs -t

# Check dynos
heroku ps

# View resource usage
heroku logs:tail
```

### Heroku Scaling

```bash
# Scale to 2 dynos
heroku ps:scale web=2

# View metrics
heroku metrics
```

---

## 🚆 Option 2: Railway (Modern - Recommended for GitHub Users)

### Prerequisites
- GitHub account
- Railway account (signup at https://railway.app)
- Railway CLI (optional)

### Deployment Steps

#### Step 1: Connect GitHub

1. Visit [Railway Dashboard](https://railway.app/dashboard)
2. Click **New Project**
3. Select **Deploy from GitHub repo**
4. Authorize Railway to access GitHub
5. Select your repository

#### Step 2: Configure Environment Variables

1. In Railway dashboard, go to your project
2. Click **Variables**
3. Add variables:
   ```
   WISE_API_KEY=your_sandbox_api_key
   WISE_API_BASE_URL=https://api.sandbox.transferwise.tech
   NODE_ENV=production
   PORT=3000
   ```

#### Step 3: Deploy

Railway automatically deploys from the `railway.json` configuration file.

```bash
# Check deployment status
# Visit: https://railway.app/dashboard
```

#### Step 4: Get Public URL

1. Go to Railway Dashboard
2. Click your service
3. Copy the public domain URL

#### Step 5: Add Custom Domain (Optional)

1. In Railway service settings
2. Click **Domain**
3. Add your custom domain
4. Update DNS records

### Railway Monitoring

- Dashboard shows real-time logs
- Resource usage monitoring
- Error tracking
- Database connections

### Railway Scaling

- Automatic scaling available
- Configure in service settings
- Pay-as-you-go pricing

---

## ☁️ Option 3: AWS ECS (Most Powerful)

### Prerequisites
- AWS Account
- AWS CLI configured
- Docker CLI installed
- ECR (Elastic Container Registry) access

### Installation

```bash
# Install AWS CLI v2
# Visit: https://aws.amazon.com/cli/

# Configure AWS credentials
aws configure
```

### Deployment Steps

#### Step 1: Run Deployment Script

```bash
chmod +x scripts/deploy-aws.sh
./scripts/deploy-aws.sh
```

Or manually:

#### Step 1a: Create ECR Repository

```bash
AWS_REGION=us-east-1
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws ecr create-repository \
  --repository-name wise-transfer-demo \
  --region $AWS_REGION
```

#### Step 1b: Login to ECR

```bash
aws ecr get-login-password --region $AWS_REGION | \
  docker login --username AWS --password-stdin \
  $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
```

#### Step 1c: Push Docker Image

```bash
docker build -t wise-transfer-demo:latest .

docker tag wise-transfer-demo:latest \
  $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/wise-transfer-demo:latest

docker push \
  $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/wise-transfer-demo:latest
```

#### Step 2: Create ECS Cluster

```bash
aws ecs create-cluster --cluster-name wise-transfer-cluster
```

#### Step 3: Create Task Definition

```bash
aws ecs register-task-definition --cli-input-json file://task-definition.json
```

#### Step 4: Create ECS Service

```bash
aws ecs create-service \
  --cluster wise-transfer-cluster \
  --service-name wise-transfer-service \
  --task-definition wise-transfer-demo:1 \
  --desired-count 1
```

#### Step 5: Set Up Load Balancer

1. AWS Console → EC2 → Load Balancers
2. Create Application Load Balancer
3. Configure target group
4. Attach to ECS service

### AWS Monitoring

```bash
# View logs
aws logs tail /ecs/wise-transfer-demo --follow

# Check service status
aws ecs describe-services \
  --cluster wise-transfer-cluster \
  --services wise-transfer-service
```

### AWS Scaling

```bash
# Auto-scaling configuration
aws application-autoscaling register-scalable-target \
  --service-namespace ecs \
  --resource-id service/wise-transfer-cluster/wise-transfer-service \
  --scalable-dimension ecs:service:DesiredCount \
  --min-capacity 1 \
  --max-capacity 10
```

---

## 📦 Option 4: Render (Simple & Reliable)

### Prerequisites
- GitHub account
- Render account (free signup at https://render.com)

### Deployment Steps

#### Step 1: Connect GitHub

1. Visit [Render Dashboard](https://dashboard.render.com)
2. Click **New +**
3. Select **Web Service**
4. Connect GitHub repository

#### Step 2: Configure Service

1. **Name**: wise-transfer-demo
2. **Environment**: Docker
3. **Branch**: main
4. **Build Command**: npm install && npm run build
5. **Start Command**: npm start

#### Step 3: Add Environment Variables

1. Go to **Environment** tab
2. Add variables:
   ```
   WISE_API_KEY=your_sandbox_api_key
   WISE_API_BASE_URL=https://api.sandbox.transferwise.tech
   NODE_ENV=production
   ```

#### Step 4: Deploy

Click **Deploy** to start deployment

#### Step 5: Get URL

- URL shown in dashboard
- Format: `https://wise-transfer-demo.onrender.com`

### Render Monitoring

- Real-time logs in dashboard
- Resource usage metrics
- Deployment history

---

## 💾 Option 5: DigitalOcean App Platform

### Prerequisites
- DigitalOcean account
- GitHub account
- doctl CLI (optional)

### Deployment Steps

#### Step 1: Connect GitHub

1. Visit [DigitalOcean App Platform](https://cloud.digitalocean.com/apps)
2. Click **Create App**
3. Select GitHub repository
4. Authorize DigitalOcean

#### Step 2: Configure App

1. **Name**: wise-transfer-demo
2. **Source**: GitHub
3. **Branch**: main
4. **Build Command**: npm install && npm run build
5. **Run Command**: npm start

#### Step 3: Add Environment Variables

1. Go to **Environment** tab
2. Add variables:
   ```
   WISE_API_KEY=your_sandbox_api_key
   WISE_API_BASE_URL=https://api.sandbox.transferwise.tech
   NODE_ENV=production
   ```

#### Step 4: Deploy

Click **Deploy** button

#### Step 5: Get URL

- URL: `https://wise-transfer-demo-xxxxx.ondigitalocean.app`

### DigitalOcean Monitoring

- Logs viewer
- Resource usage
- Deployment status

---

## 🔒 Security Best Practices for Live Deployment

### 1. Environment Variables

✅ **DO:**
- Use production environment variables
- Store secrets in platform secret managers
- Rotate API keys regularly
- Use different keys per environment

❌ **DON'T:**
- Commit secrets to version control
- Expose API keys in logs
- Share credentials via email
- Use the same key across environments

### 2. HTTPS/SSL

```bash
# Enable automatically on most platforms
# Heroku, Railway, Render, DigitalOcean all provide free SSL

# Test SSL
curl -I https://your-domain.com
```

### 3. Monitoring & Alerts

Set up monitoring for:
- API response time
- Error rates
- CPU/Memory usage
- Disk space
- Database connections

### 4. Logging

Enable centralized logging:
- CloudWatch (AWS)
- Papertrail
- DataDog
- Loggly

### 5. Database Security

- Use strong passwords
- Enable encryption at rest
- Regular backups
- Restricted network access

---

## 📊 Access Your Live Application

Once deployed, access at:

```
https://your-app-url.com
```

### Test Endpoints

```bash
# Test API
curl https://your-app-url.com

# Get account info
curl -H "Authorization: Bearer YOUR_API_KEY" \
  https://your-app-url.com/account

# Get balance
curl -H "Authorization: Bearer YOUR_API_KEY" \
  https://your-app-url.com/balance
```

---

## 💰 Cost Estimation (Monthly)

### Heroku
- Basic: $7/month (eco)
- Standard: $7-50/month
- Production: $50-2500/month

### Railway
- Pay-as-you-go
- ~$5-100/month for small apps

### AWS ECS
- Compute: $10-500/month
- Data transfer: $0.09/GB
- Additional services: varies

### Render
- Free tier available
- Paid: $7-100/month

### DigitalOcean
- Basic app: $5-100/month
- Databases: $12-600/month

---

## 🆘 Troubleshooting

### Application Won't Start

```bash
# Check logs
heroku logs -t        # Heroku
railway logs          # Railway

# Common issues:
# 1. Missing environment variables
# 2. Port binding error
# 3. Database connection failure
```

### API Key Not Working

- Verify API key in environment variables
- Check API key hasn't expired
- Confirm sandbox URL is correct
- Check rate limiting

### High CPU/Memory Usage

- Check application logs for errors
- Monitor database queries
- Enable auto-scaling
- Optimize code performance

### Custom Domain Not Working

- Verify DNS records
- Wait for DNS propagation (up to 48 hours)
- Check SSL certificate status
- Contact platform support

---

## 📚 Additional Resources

### Heroku
- https://devcenter.heroku.com
- https://www.heroku.com/pricing

### Railway
- https://docs.railway.app
- https://railway.app

### AWS ECS
- https://docs.aws.amazon.com/ecs
- https://aws.amazon.com/ecs/pricing

### Render
- https://render.com/docs
- https://render.com/pricing

### DigitalOcean
- https://docs.digitalocean.com/products/app-platform
- https://www.digitalocean.com/pricing

### Wise API
- https://wise.com/us/business/send-money-api
- https://docs-2.wise.com

---

## 🎉 You're Live!

Once deployed, your Wise Transfer API Demo will be:
- ✅ Accessible 24/7
- ✅ Automatically scaled
- ✅ HTTPS secured
- ✅ Monitored and logged
- ✅ Ready for production use

---

**Last Updated**: July 2026

**Need Help?** Check the logs and refer to platform-specific documentation.
