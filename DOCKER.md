# Docker Deployment Guide

## Overview

This project uses a **scalable, maintainable Docker setup** for deploying Flutter web applications. The solution avoids complex permission management while maintaining security best practices.

## Architecture

### Multi-Stage Build

1. **Builder Stage** (`ubuntu:22.04`)
   - Installs Flutter SDK
   - Builds the Flutter web app
   - Runs as root (standard practice for build containers)

2. **Production Stage** (`nginx:alpine`)
   - Lightweight nginx server
   - Serves static files only
   - Runs as non-root user (security best practice)

## Key Features

✅ **Simple & Maintainable**
- No complex user permission management
- Easy to debug and update
- Clear separation of build and runtime

✅ **Optimized Performance**
- Layer caching (pubspec.yaml copied first)
- Static asset caching headers
- Minimal final image size (~50MB)

✅ **Scalable**
- Build arguments for version control
- Easy to update Flutter version
- Works with any CI/CD platform

✅ **Secure**
- Non-root user in production
- Minimal attack surface (alpine base)
- No unnecessary dependencies

## Local Development

### Using Docker Compose

```bash
docker-compose up --build
```

Visit http://localhost:8080

### Using Build Script

```bash
chmod +x scripts/build.sh
./scripts/build.sh
docker run -p 8080:80 gameon-active:latest
```

### Manual Build

```bash
docker build -t gameon-active:latest .
docker run -p 8080:80 gameon-active:latest
```

## Customization

### Update Flutter Version

Edit `Dockerfile` and change the build argument:

```dockerfile
ARG FLUTTER_CHANNEL=stable  # or 'beta', 'dev'
```

Or build with custom version:

```bash
docker build --build-arg FLUTTER_CHANNEL=beta -t gameon-active:beta .
```

### Change Web Renderer

Edit the build command in `Dockerfile`:

```dockerfile
# Options: canvaskit (default) or html
RUN flutter build web --release --web-renderer html
```

## Troubleshooting

### Build Fails

1. Check Flutter version compatibility
2. Verify `pubspec.yaml` is valid
3. Check Docker logs: `docker build --progress=plain .`

### App Not Loading

1. Verify nginx config: `docker exec <container> cat /etc/nginx/conf.d/default.conf`
2. Check file permissions: `docker exec <container> ls -la /usr/share/nginx/html`
3. Review nginx logs: `docker logs <container>`

### Performance Issues

1. Enable build cache: `docker build --cache-from gameon-active:latest .`
2. Check asset sizes in `build/web`
3. Verify caching headers in browser DevTools

## Best Practices

1. **Version Pinning**: Use specific Flutter versions in production
2. **Regular Updates**: Keep base images and dependencies updated
3. **Security Scanning**: Run `docker scan` on built images
4. **Layer Optimization**: Order Dockerfile commands by change frequency
5. **Build Context**: Use `.dockerignore` to exclude unnecessary files

## CI/CD Integration

This Dockerfile works with:
- ✅ Render
- ✅ GitHub Actions
- ✅ GitLab CI
- ✅ AWS ECS/Fargate
- ✅ Google Cloud Run
- ✅ Azure Container Instances
- ✅ Any Docker-compatible platform

## File Structure

```
.
├── Dockerfile              # Main build configuration
├── docker-compose.yml     # Local development setup
├── .dockerignore          # Build context exclusions
├── scripts/
│   └── build.sh          # Build helper script
└── DEPLOY.md             # Deployment instructions
```

## Support

For issues or questions:
- Check [DEPLOY.md](./DEPLOY.md) for platform-specific guides
- Review [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- Check [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

