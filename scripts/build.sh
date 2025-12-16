#!/bin/bash
set -e

# Build script for local Docker testing
# Usage: ./scripts/build.sh [tag]

IMAGE_NAME="gameon-active"
TAG="${1:-latest}"

echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
docker build -t "${IMAGE_NAME}:${TAG}" .

echo "Build complete! Run with:"
echo "  docker run -p 8080:80 ${IMAGE_NAME}:${TAG}"

