#!/bin/bash
# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Run MLflow container
sudo docker run -d -p 5000:5000 \
  -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
  -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
  -e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
  --name mlflow-tracking \
  mlflow/mlflow \
  server \
    --backend-store-uri /mlflow \
    --default-artifact-root s3://${S3_BUCKET}/artifacts \
    --host 0.0.0.0