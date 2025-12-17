# Build stage - use official Flutter image to avoid git/ownership issues
FROM ghcr.io/cirruslabs/flutter:3.24.0 AS builder

# Ensure web is enabled and cached
RUN flutter config --enable-web --no-analytics && \
    flutter precache --web

WORKDIR /app

# Copy pubspec files first for better layer caching
COPY pubspec.yaml ./

# Get dependencies
RUN flutter pub get

# Copy source code
COPY . .

# Build Flutter web app (default to HTML renderer for better mobile compatibility)
# Change WEB_RENDERER to "canvaskit" if you specifically need it.
ARG WEB_RENDERER=html
RUN flutter build web --release --web-renderer ${WEB_RENDERER} --pwa-strategy=none

# Production stage - Minimal nginx image
FROM nginx:alpine

# Copy nginx configuration for SPA routing
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
    } \
    # Cache static assets \
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ { \
        expires 1y; \
        add_header Cache-Control "public, immutable"; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Prepare nginx cache/run/log directories with correct ownership and clean user directive
RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx /run && \
    touch /run/nginx.pid && \
    chown -R nginx:nginx /var/cache/nginx /var/run /var/log/nginx /run /etc/nginx/conf.d && \
    sed -i '/^user/d' /etc/nginx/nginx.conf

# Copy built files from builder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Use nginx user (non-root) for security
USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
