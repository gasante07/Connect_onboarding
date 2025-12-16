# Deploying to Render

This guide will help you deploy your Flutter web app to Render.

## Prerequisites

1. A Render account (sign up at [render.com](https://render.com))
2. Your project pushed to a Git repository (GitHub, GitLab, or Bitbucket)

## Deployment Steps

### Option 1: Using Docker (Recommended) ✅

This is the most reliable method for Flutter apps on Render.

1. **Push your code to Git**
   ```bash
   git add .
   git commit -m "Add Render deployment configuration"
   git push
   ```

2. **Create a new Web Service on Render**
   - Go to [Render Dashboard](https://dashboard.render.com)
   - Click "New +" → "Web Service"
   - Connect your Git repository
   - Render will automatically detect the `render.yaml` file and use the Dockerfile

3. **Deploy**
   - Click "Create Web Service"
   - Render will build using Docker and deploy your app automatically
   - The first build may take 5-10 minutes (Flutter installation + build)

### Option 2: Static Site (Alternative)

If you prefer to use Render's Static Site service, you'll need to build locally first:

1. **Build your Flutter web app locally**
   ```bash
   flutter pub get
   flutter build web --release
   ```

2. **Create a new Static Site on Render**
   - Go to Render Dashboard → "New +" → "Static Site"
   - Connect your repository

3. **Set the following settings**:
   - **Name**: `gameon-active`
   - **Build Command**: Leave empty (pre-built)
   - **Publish Directory**: `build/web`
   - **Environment**: Static Site

4. **Push your built files** (you'll need to commit the `build/web` folder)
   ```bash
   git add build/web
   git commit -m "Add pre-built web files"
   git push
   ```

5. **Deploy**

### Option 3: Manual Web Service Configuration

If you prefer to configure manually without render.yaml:

1. **Create a new Web Service**
   - Go to Render Dashboard → "New +" → "Web Service"
   - Connect your repository

2. **Set the following settings**:
   - **Name**: `gameon-active`
   - **Environment**: Docker
   - **Dockerfile Path**: `./Dockerfile`
   - **Docker Context**: `.`

3. **Add Environment Variables** (if needed):
   - `FLUTTER_BASE_HREF`: `/` (for root path deployment)

4. **Deploy**

## Important Notes

- **Flutter SDK**: Render's build environment includes Flutter, but you may need to ensure the Flutter SDK is available. If you encounter issues, you might need to use a custom Docker image or build script.

- **Build Time**: Flutter web builds can take several minutes. Be patient during the first deployment.

- **Custom Domain**: After deployment, you can add a custom domain in the Render dashboard under your service settings.

- **Environment Variables**: If your app uses environment variables, add them in the Render dashboard under your service's "Environment" tab.

## Troubleshooting

### Build Fails
- Check that Flutter is available in the build environment
- Verify your `pubspec.yaml` is valid
- Check build logs in Render dashboard

### App Not Loading
- Verify the publish directory is set to `build/web`
- Check that `index.html` exists in `build/web`
- Review browser console for errors

### Assets Not Loading
- Ensure all assets are included in `pubspec.yaml`
- Verify asset paths are correct in your Dart code
- Check that assets are copied to `build/web` during build

## Alternative: Using Docker

If you encounter issues with Flutter on Render's default environment, you can use a Dockerfile:

```dockerfile
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa

# Install Flutter
ENV FLUTTER_VERSION=3.24.0
RUN git clone https://github.com/flutter/flutter.git -b stable /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

WORKDIR /app
COPY . .

# Build Flutter web
RUN flutter pub get && flutter build web --release

# Serve with a simple HTTP server
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Then update `render.yaml` to use Docker instead of static site.

## Support

For more information, visit:
- [Render Documentation](https://render.com/docs)
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
