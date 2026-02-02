#!/bin/bash
set -e

# Визначаємо namespace, щоб не прописувати його в кожній команді
NAMESPACE="cinema-app"

echo "Creating secrets in namespace: $NAMESPACE"

# 1. PostgreSQL секрет
kubectl create secret generic postgresql-secret \
  --namespace=$NAMESPACE \
  --from-literal=username=postgres \
  --from-literal=password="${POSTGRES_PASSWORD}" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic movie-service-secret \
  --namespace=$NAMESPACE \
  --from-literal=ADMIN_MAIL="${ADMIN_MAIL}" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic email-notification-secrets \
  --namespace=$NAMESPACE \
  --from-literal=MAIL_USERNAME="${MAIL_USERNAME}" \
  --from-literal=MAIL_PASSWORD="${MAIL_PASSWORD}" \
  --from-literal=ELASTIC_USER="${ELASTIC_USER}" \
  --dry-run=client -o yaml | kubectl apply -f -

kubectl create secret generic google-oauth-secret \
  --namespace=$NAMESPACE \
  --from-literal=GOOGLE_CLIENT_ID="${GOOGLE_CLIENT_ID}" \
  --from-literal=GOOGLE_CLIENT_SECRET="${GOOGLE_CLIENT_SECRET}" \
  --dry-run=client -o yaml | kubectl apply -f -

echo "All secrets applied successfully."