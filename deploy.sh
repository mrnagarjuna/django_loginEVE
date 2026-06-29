#!/bin/bash
set -e

echo "Stopping old container..."
sudo docker stop myc1 || true
sudo docker rm myc1 || true

echo "Building Docker image..."
sudo docker build -t djangoapp .

echo "Starting container..."
sudo docker run -d \
  --name myc1 \
  --restart always \
  -p 8000:8000 \
  djangoapp

echo "Deployment completed."

sudo docker ps
