# Deployment Guide for Wise Transfer API Demo

This guide covers deploying the Wise Transfer API Demo to various environments.

## Quick Start with Docker

### Prerequisites
- Docker (v20.10+)
- Docker Compose (v1.29+)

### Build Docker Image

```bash
docker build -t wise-transfer-demo:1.0.0 .
```

### Run with Docker

```bash
docker run -d \
  -e WISE_API_KEY=your_api_key \
  -e WISE_API_BASE_URL=https://api.sandbox.transferwise.tech \
  -p 3000:3000 \
  --name wise-demo \
  wise-transfer-demo:1.0.0
```

### Run with Docker Compose

```bash
# Copy environment file
cp .env.example .env

# Edit .env with your API credentials
nano .env

# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## Environment Variables

All deployments require the following environment variables:

- `WISE_API_KEY` - Your Wise Transfer API key
- `WISE_API_BASE_URL` - API endpoint (default: https://api.sandbox.transferwise.tech)
- `NODE_ENV` - Environment (development/production)
- `PORT` - Application port (default: 3000)

## Deployment Scripts

### Build Script

```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

This script:
- Installs dependencies
- Compiles TypeScript
- Runs tests
- Prepares artifacts

### Deploy Script

```bash
chmod +x scripts/deploy.sh
./scripts/deploy.sh production
```

This script:
- Builds the application
- Runs tests
- Creates Docker image
- Tags for deployment

## Platform-Specific Deployment

### AWS ECS

1. Create ECR repository
2. Push Docker image:

```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com

docker tag wise-transfer-demo:1.0.0 <account-id>.dkr.ecr.us-east-1.amazonaws.com/wise-transfer-demo:1.0.0

docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/wise-transfer-demo:1.0.0
```

3. Create ECS task definition and service

### Heroku

```bash
# Install Heroku CLI
npm install -g heroku

# Login to Heroku
heroku login

# Create app
heroku create wise-transfer-demo

# Set environment variables
heroku config:set WISE_API_KEY=your_api_key

# Deploy
git push heroku main
```

### Kubernetes

Create `k8s-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wise-transfer-demo
spec:
  replicas: 3
  selector:
    matchLabels:
      app: wise-transfer-demo
  template:
    metadata:
      labels:
        app: wise-transfer-demo
    spec:
      containers:
      - name: wise-transfer-demo
        image: wise-transfer-demo:1.0.0
        ports:
        - containerPort: 3000
        env:
        - name: WISE_API_KEY
          valueFrom:
            secretKeyRef:
              name: wise-secrets
              key: api-key
```

Deploy:

```bash
kubectl apply -f k8s-deployment.yaml
```

## Health Checks

The application exposes a health check endpoint:

```bash
curl http://localhost:3000/health
```

## Monitoring

### Docker Logs

```bash
docker logs -f wise-demo
```

### Docker Compose Logs

```bash
docker-compose logs -f wise-transfer-demo
```

## Cleanup

### Remove Docker Container

```bash
docker stop wise-demo
docker rm wise-demo
```

### Remove Docker Image

```bash
docker rmi wise-transfer-demo:1.0.0
```

### Docker Compose Cleanup

```bash
docker-compose down -v
```

## Troubleshooting

### API Key Not Found

```bash
Error: WISE_API_KEY environment variable not set
```

Solution: Set the environment variable before running:

```bash
export WISE_API_KEY=your_api_key
docker run -e WISE_API_KEY=$WISE_API_KEY ...
```

### Port Already in Use

```bash
Error: Port 3000 is already in use
```

Solution: Use a different port:

```bash
docker run -p 3001:3000 ...
```

### Build Fails

```bash
npm ERR! 404 Not Found
```

Solution: Clear npm cache and rebuild:

```bash
npm cache clean --force
npm install
npm run build
```

## Best Practices

1. **Use environment variables** for sensitive data
2. **Always run tests** before deployment
3. **Use specific version tags** for Docker images
4. **Implement health checks** for monitoring
5. **Use Docker secrets** for production deployments
6. **Set resource limits** in Docker
7. **Enable auto-restart** for containers
8. **Use Docker networks** for multi-container setups

## Security Considerations

1. **Never commit .env files** to version control
2. **Use .env.example** as a template
3. **Rotate API keys** regularly
4. **Use HTTPS** in production
5. **Implement rate limiting** for API endpoints
6. **Use secret management** services (AWS Secrets Manager, Vault, etc.)
7. **Keep dependencies updated** regularly
8. **Use Docker security scanning** for images

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Wise API Documentation](https://wise.com/us/business/send-money-api)
- [Node.js Docker Best Practices](https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md)

---

Last Updated: July 2026
