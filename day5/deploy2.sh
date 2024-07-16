#!/bin/bash

# Initialize Docker Swarm
docker swarm init

# Deploy the stack using Docker Swarm
docker stack deploy -c docker-compose-swarm.yml myapp

# Start Minikube
minikube start

kubectl apply -f shared-pvc.yaml
kubectl apply -f db-pvc.yaml
kubectl apply -f frontend-deployment.yaml
kubectl apply -f backend-deployment.yaml
kubectl apply -f db-deployment.yaml

# Deploy using Docker Compose
docker-compose up -d
