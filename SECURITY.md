# Security Guide for Wise Transfer API Demo

## 🔒 Security Best Practices

### Environment Variables

Never commit sensitive information to version control:

- ❌ DO NOT commit `.env` files
- ❌ DO NOT commit API keys, passwords, or tokens
- ❌ DO NOT commit database credentials
- ✅ DO commit `.env.example` with placeholder values only
- ✅ DO add `.env` to `.gitignore`

### Using GitHub Secrets for CI/CD

If you're using GitHub Actions, add secrets to your repository:

1. Go to: **Settings → Secrets and variables → Actions**
2. Click **New repository secret**
3. Add your secrets:
   - `WISE_API_KEY` - Your Wise Transfer API key
   - `WISE_API_BASE_URL` - API endpoint URL
   - Database credentials (if needed)

### Example GitHub Actions Workflow

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v2
      
      - name: Build and Test
        env:
          WISE_API_KEY: ${{ secrets.WISE_API_KEY }}
          WISE_API_BASE_URL: ${{ secrets.WISE_API_BASE_URL }}
        run: |
          npm install
          npm run build
          npm test
      
      - name: Build Docker Image
        run: docker build -t wise-transfer-demo:latest .
      
      - name: Deploy
        env:
          WISE_API_KEY: ${{ secrets.WISE_API_KEY }}
        run: |
          docker run -e WISE_API_KEY=$WISE_API_KEY wise-transfer-demo:latest
```

### Local Development Setup

For local development, create a `.env` file (never commit this):

```bash
cp .env.example .env

# Edit .env with your actual credentials
nano .env
```

Your `.env` file will be ignored by Git automatically.

### Docker Secrets (Production)

For Docker deployments, use Docker secrets instead of environment variables:

```bash
# Create a secret
echo "your_api_key_here" | docker secret create wise_api_key -

# Use in docker-compose.yml
services:
  wise-transfer-demo:
    environment:
      WISE_API_KEY_FILE: /run/secrets/wise_api_key
    secrets:
      - wise_api_key

secrets:
  wise_api_key:
    external: true
```

### Secret Management for Production

For production deployments, use dedicated secret management:

1. **AWS Secrets Manager**
   ```bash
   aws secretsmanager create-secret --name wise-api-key --secret-string "your_key"
   ```

2. **HashiCorp Vault**
   ```bash
   vault kv put secret/wise api_key="your_key"
   ```

3. **Azure Key Vault**
   ```bash
   az keyvault secret set --vault-name MyKeyVault --name WiseApiKey --value "your_key"
   ```

### API Key Security

- ✅ Use API-specific keys with minimal permissions
- ✅ Rotate keys regularly (at least quarterly)
- ✅ Monitor API key usage and access logs
- ✅ Use separate keys for different environments (dev, staging, prod)
- ✅ Revoke compromised keys immediately
- ❌ Do not share API keys via email or chat
- ❌ Do not use the same key across environments

### .gitignore Configuration

Ensure your `.gitignore` includes:

```
# Environment variables
.env
.env.local
.env.*.local

# Dependencies
node_modules/
npm-debug.log*

# Build outputs
dist/
build/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Docker
.docker/
docker-compose.override.yml
```

### Checking for Exposed Secrets

If you accidentally commit secrets, use these tools:

```bash
# Check git history for secrets
git-secrets --scan

# Install git-secrets
brew install git-secrets

# Configure git hooks
git secrets --install
git secrets --register-aws
```

### Incident Response

If you suspect a secret has been exposed:

1. **Immediately revoke the compromised secret**
2. **Generate a new secret/API key**
3. **Review access logs** for unauthorized activity
4. **Update all systems** with the new secret
5. **Document the incident**
6. **Update your security processes**

### Additional Resources

- [OWASP - Secrets Management](https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html)
- [GitHub - Security Best Practices](https://docs.github.com/en/code-security)
- [Wise API Security](https://wise.com/us/business/send-money-api)
- [Docker Secrets Documentation](https://docs.docker.com/engine/swarm/secrets/)
- [HashiCorp Vault](https://www.vaultproject.io/)

---

**Last Updated**: July 2026

