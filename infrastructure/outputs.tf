output "mlflow_tracking_url" {
  value = "http://${aws_instance.mlflow_tracking.private_ip}:5000"
}

output "s3_buckets" {
  value = {
    raw_data     = aws_s3_bucket.data_buckets["raw-data"].id
    processed    = aws_s3_bucket.data_buckets["processed-data"].id
    mlflow       = aws_s3_bucket.data_buckets["mlflow-artifacts"].id
  }
}

output "github_actions_credentials" {
  value = {
    access_key = aws_iam_access_key.github.id
    secret_key = aws_iam_access_key.github.secret
  }
  sensitive = true
}