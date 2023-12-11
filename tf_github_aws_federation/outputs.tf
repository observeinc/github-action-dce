output "role_arn" {
  description = "The ARN of the IAM role created for GitHub Actions."
  value       = aws_iam_role.github_actions_ci.arn
}
