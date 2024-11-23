#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install Argo CD
echo "Installing Argo CD..."

# Create a namespace for Argo CD
kubectl create namespace argocd

# Install Argo CD using the official manifests
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD components to be ready
echo "Waiting for Argo CD components to be ready..."
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd

# Get the initial admin password
echo "Fetching the initial admin password..."
ARGOCD_SERVER=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
ARGOCD_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode)

echo "Argo CD installed successfully!"
echo "Argo CD Server: $ARGOCD_SERVER"
echo "Initial Admin Password: $ARGOCD_PASSWORD"


# Expose the Argo CD server using a LoadBalancer service
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

echo "Argo CD setup complete!"