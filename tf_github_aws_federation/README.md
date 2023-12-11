# DCE Github Actions Terraform

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.github_actions_ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.dce_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [github_actions_secret.aws_ci_role](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_secret) | resource |
| [aws_iam_openid_connect_provider.github_actions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_openid_connect_provider) | data source |
| [aws_iam_policy_document.github_actions_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | The GitHub organization name. | `string` | n/a | yes |
| <a name="input_repository"></a> [repository](#input\_repository) | The GitHub repository name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The ARN of the IAM role created for GitHub Actions. |
