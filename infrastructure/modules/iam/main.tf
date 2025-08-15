resource "aws_iam_user" "github_actions" {
  name = "${var.project_name}-github-actions"
}

resource "aws_iam_access_key" "github" {
  user = aws_iam_user.github_actions.name
}

resource "aws_iam_user_policy" "deploy_access" {
  name = "${var.project_name}-deploy-policy"
  user = aws_iam_user.github_actions.name

  policy = jsonencode({
    Version = "2025-08-13"
    Statement = [
      {
        Action = [
          "ecr:*",
          "ecs:*",
          "s3:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}