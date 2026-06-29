#!/bin/bash

set -e

cd /home/ubuntu/django_loginEVE

echo "Pulling latest code..."
git pull origin main

echo "Stopping old container..."
sudo docker stop myc1 || true
sudo docker rm myc1 || true

echo "Removing old image..."
sudo docker rmi djangoapp:latest || true

echo "Building Docker image..."
sudo docker build -t djangoapp:latest .

echo "Starting container..."
sudo docker run -d \
  --name myc1 \
  --restart unless-stopped \
  -p 8000:8000 \
  djangoapp:latest

echo "Deployment completed."

sudo docker ps
