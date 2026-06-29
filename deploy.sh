#!/bin/bash
set -e

cd /home/ubuntu/django_loginEVE

echo "Pulling latest code..."
git pull origin main

echo "Stopping old container..."
sudo docker stop myc1 || true

echo "Removing old container..."
sudo docker rm myc1 || true

echo "Building image..."
sudo docker build -t djangoapp .

echo "Starting container..."
sudo docker run -d \
  --name myc1 \
  --restart always \
  -p 8000:8000 \
  djangoapp

echo "Deployment completed"

sudo docker ps
