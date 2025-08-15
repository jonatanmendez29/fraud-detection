resource "aws_s3_bucket" "data_buckets" {
  for_each = toset(["raw-data", "processed-data", "mlflow-artifacts"])

  bucket = "${var.project_name}-${var.environment}-${each.key}"
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  for_each = aws_s3_bucket.data_buckets

  bucket = each.value.id
  versioning_configuration {
    status = "Enabled"
  }
}