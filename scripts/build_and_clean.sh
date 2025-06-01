#!/bin/bash

# chmod +x scripts/build_and_clean.sh
# ./scripts/build_and_clean.sh

set -e

IMAGE_NAME="hello-docker:latest"
DOCKERFILE="Dockerfiles/Dockerfile_native_upx"

echo "🔨 Building Docker image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" -f "$DOCKERFILE" .

echo "🧹 Cleaning up dangling images..."
dangling=$(docker images -f "dangling=true" -q)

if [ -n "$dangling" ]; then
  echo "Removing dangling images..."
  docker rmi $dangling
else
  echo "No dangling images to remove."
fi

echo "✅ Done."