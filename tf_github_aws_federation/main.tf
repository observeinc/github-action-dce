data "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

locals {
  oidc_claim_prefix = trimprefix(data.aws_iam_openid_connect_provider.github_actions.url, "https://")
}

data "aws_iam_policy_document" "github_actions_assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github_actions.arn]
    }

    condition {
      test     = "StringLike"
      variable = "${local.oidc_claim_prefix}:sub"
      values   = ["repo:${var.organization}/${var.repository}:*"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_claim_prefix}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_actions_ci" {
  name = "${var.repository}-gha-ci"

  assume_role_policy = data.aws_iam_policy_document.github_actions_assume_role.json

  tags = {
    Principal  = "GitHub Actions"
    Repository = "${var.organization}/${var.repository}"
  }
}

resource "aws_iam_role_policy_attachment" "dce_policy_attachment" {
  role       = aws_iam_role.github_actions_ci.name
  policy_arn = "arn:aws:iam::460044344528:policy/dce-user-playground-20230917"
}

resource "github_actions_secret" "aws_ci_role" {
  repository      = var.repository
  secret_name     = "AWS_ROLE_ARN"
  plaintext_value = aws_iam_role.github_actions_ci.arn
}
