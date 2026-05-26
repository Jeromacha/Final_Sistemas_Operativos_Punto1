#!/bin/bash

set -e

AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="618015514167"
ECR_REPOSITORY="lambda-final-fastapi"
IMAGE_TAG="latest"

IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG"

echo "Iniciando sesión en ECR..."
aws ecr get-login-password --region "$AWS_REGION" | docker login \
  --username AWS \
  --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

echo "Construyendo y subiendo imagen compatible con Lambda..."
docker buildx build \
  --platform linux/amd64 \
  --provenance=false \
  -t "$IMAGE_URI" \
  --push .

echo "Imagen publicada correctamente:"
echo "$IMAGE_URI"