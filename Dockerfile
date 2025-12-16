# Build stage - Use official Flutter image or install Flutter simply
FROM ubuntu:22.04 AS builder

# Build arguments for version control
ARG FLUTTER_VERSION=stable
ARG FLUTTER_CHANNEL=stable

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
ENV FLUTTER_HOME=/usr/local/flutter
ENV PATH="${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:${PATH}"

# Clone Flutter and configure for web (run as root - acceptable in build stage)
# Using build args allows easy version updates
RUN git clone https://github.com/flutter/flutter.git -b ${FLUTTER_CHANNEL} ${FLUTTER_HOME} && \
    flutter config --enable-web --no-analytics && \
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

# Copy built files from builder
COPY --from=builder /app/build/web /usr/share/nginx/html

# Use nginx user (non-root) for security
USER nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
