#!/bin/bash

# chmod +x scripts/test_build_and_run.sh
# ./scripts/test_build_and_run.sh
# Script: test_build_and_run.sh
# Purpose: Build image, run container, verify output, and clean up.

set -e

IMAGE_NAME="hello-docker"

echo "🔍 Checking if Docker daemon is running..."
if ! docker info > /dev/null 2>&1; then
  echo "❌ Docker daemon is not running. Please start Docker and try again."
  exit 1
fi

echo "🔎 Checking if Docker image '$IMAGE_NAME' exists..."
if ! docker image inspect "$IMAGE_NAME" > /dev/null 2>&1; then
  echo "⚠️ Docker image '$IMAGE_NAME' not found. Trying to build it using ./scripts/build_and_clean.sh..."
  if [ -f ./scripts/build_and_clean.sh ]; then
    chmod +x ./scripts/build_and_clean.sh
    ./scripts/build_and_clean.sh
  else
    echo "❌ Build script './scripts/build_and_clean.sh' not found. Cannot proceed."
    exit 1
  fi
fi

echo "🚀 Starting container with Docker Compose..."
docker compose up -d

echo "⏳ Waiting until container is running..."
CONTAINER_NAME="api"
MAX_ATTEMPTS=10
ATTEMPT=1

while [[ $(docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME" 2>/dev/null) != "true" ]]; do
  if [ "$ATTEMPT" -ge "$MAX_ATTEMPTS" ]; then
    echo "❌ Container did not start after $MAX_ATTEMPTS attempts."
    docker compose down -v
    exit 1
  fi
  echo "⌛ Waiting... ($ATTEMPT/$MAX_ATTEMPTS)"
  ATTEMPT=$((ATTEMPT + 1))
  sleep 1
done

echo "✅ Container is running!"

URL="http://localhost:8080"
echo "🌐 Waiting for HTTP service to be ready at $URL..."
until curl -s "$URL" > /dev/null; do
  echo "⌛ Waiting for HTTP response..."
  sleep 1
done

echo "🔍 Sending request to $URL..."
RESPONSE=$(curl -s "$URL")

echo "📦 Response: $RESPONSE"

if [[ "$RESPONSE" == *"Hello Docker"* ]]; then
  echo "✅ Test passed: Response contains expected output."
else
  echo "❌ Test failed: Response does not contain expected output."
  docker compose down -v
  exit 1
fi

echo "🧹 Stopping and removing container..."
docker compose down -v
echo "✅ Cleanup complete."
