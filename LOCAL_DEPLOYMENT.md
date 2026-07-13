# Local Deployment Guide

## 🚀 Quick Start (Recommended)

### Prerequisites

- Docker Desktop (v20.10+)
- Docker Compose (v1.29+)
- Terminal/Command line access

### Download Docker

- **Mac**: https://www.docker.com/products/docker-desktop
- **Windows**: https://www.docker.com/products/docker-desktop
- **Linux**: https://docs.docker.com/engine/install/

## 📦 Step-by-Step Deployment

### 1. Clone Repository

```bash
git clone https://github.com/jamesbiwei-gif/Sandbox.wise-transfer-apl.git
cd Sandbox.wise-transfer-apl
```

### 2. Set Up Environment

```bash
cp .env.example .env
```

Then edit `.env` and add your Wise Transfer API key:

```bash
# Edit with your preferred editor
nano .env
# or
vim .env
# or
code .env  # if using VS Code
```

Make sure to replace `your_api_key_here` with your actual API key from [Wise Developer Portal](https://wise.com/us/business/send-money-api)

### 3. Run Quick Start Script

```bash
chmod +x scripts/quickstart.sh
./scripts/quickstart.sh
```

Or manually:

```bash
docker-compose up -d
```

### 4. Verify Deployment

```bash
# Check if container is running
docker-compose ps

# View logs
docker-compose logs -f
```

## 🌐 Access Your Application

### Local Access

```
http://localhost:3000
```

### API Endpoints

Once deployed, you can test the API:

```bash
# Test with curl
curl http://localhost:3000

# Get account info
curl -H "Authorization: Bearer YOUR_API_KEY" http://localhost:3000/account

# Get balance
curl -H "Authorization: Bearer YOUR_API_KEY" http://localhost:3000/balance
```

## 📊 Useful Commands

### View Logs

```bash
# Real-time logs
docker-compose logs -f

# Last 100 lines
docker-compose logs --tail=100
```

### Access Container Shell

```bash
docker-compose exec wise-transfer-demo sh
```

### Stop Application

```bash
docker-compose down
```

### Restart Application

```bash
docker-compose restart
```

### Rebuild Image

```bash
docker-compose build --no-cache
```

### View Running Containers

```bash
docker-compose ps
```

## 🐛 Troubleshooting

### Port 3000 Already in Use

```bash
# Change port in docker-compose.yml
# Change: 3000:3000 to 8000:3000
nano docker-compose.yml

# Then access at http://localhost:8000
```

### API Key Not Working

```bash
# Verify .env file has correct API key
cat .env

# Check API key format and validity
# Visit: https://wise.com/us/business/send-money-api
```

### Docker Not Starting

```bash
# Check Docker daemon
docker --version

# Restart Docker Desktop
# Mac/Windows: Docker Desktop menu → Restart
# Linux: sudo systemctl restart docker
```

### Out of Memory

```bash
# Increase Docker memory limit
# Docker Desktop → Preferences → Resources → Memory (increase to 4GB+)
```

## 📈 Performance

### Resource Usage

- **CPU**: ~100-200MB
- **Memory**: ~300-500MB (idle)
- **Disk**: ~1GB (with dependencies)

### Optimization

```bash
# Use smaller base image
# Edit Dockerfile: FROM node:18-alpine (already optimized)

# Clear old images
docker system prune -a

# Remove unused volumes
docker volume prune
```

## 🔐 Security Notes

- ✅ `.env` file is in `.gitignore` - never commits to repo
- ✅ API key is only in your local `.env`
- ✅ Container uses read-only volumes where possible
- ✅ No hardcoded secrets in code

## 📚 Next Steps

1. Test API endpoints with curl or Postman
2. Create a Postman collection for API testing
3. Set up monitoring and logging
4. Deploy to production platform (Heroku, AWS, etc.)

## 🆘 Support

For issues:

1. Check [DEPLOYMENT.md](./DEPLOYMENT.md) for advanced options
2. Review [SECURITY.md](./SECURITY.md) for security setup
3. Check Docker logs: `docker-compose logs`
4. Visit [Wise API Documentation](https://wise.com/us/business/send-money-api)

---

**Last Updated**: July 2026
