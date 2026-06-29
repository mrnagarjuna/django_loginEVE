#!/bin/bash
set -e

cd /home/ubuntu/django_loginEVE

echo "Pulling latest code..."
git pull origin main


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
