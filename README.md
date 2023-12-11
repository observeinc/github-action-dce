# DCE Environment Setup and Login GitHub Action

This GitHub Action provisions or decommissions a Dynamic Cloud Environment (DCE) lease. It is designed to create an ephemeral AWS account with a specified budget and duration or to clean up the lease after use.

Certainly! Below is an expanded set of instructions for your Terraform module for AWS/GitHub Federation. This includes steps for super admins to set up the OIDC provider, as well as instructions for module users on how to use the module.

## Terraform Module for AWS/GitHub Federation

This Terraform module is designed to streamline the setup of AWS/GitHub federation, which involves setting up necessary AWS IAM roles and policies and integrating them with GitHub Actions. The module is split into two main parts: setup by a super admin (to create the OIDC provider in AWS) and usage by module users (to create the necessary roles using the module).

### Super Admin Instructions: Initial Setting Up OIDC Provider

As a super admin, your role is to set up the OIDC provider in AWS. This is a one-time setup that needs to be performed before module users can create the necessary roles.

1. **Log in to the AWS Management Console** as an admin user.
2. **Navigate to IAM** (Identity and Access Management).
3. **Go to Identity Providers** and choose **Add Provider**.
4. **Select 'OpenID Connect'** as the provider type.
5. **Set the Provider URL** to `https://token.actions.githubusercontent.com`.
6. **Click Get thumbprint**
7. **Add 'sts.amazonaws.com' as an Audience**.
8. **Complete the creation process** for the OIDC provider.

### Module User Instructions: Using the Module

Once the OIDC provider is set up by the super admin, module users can proceed to use the Terraform module.

see main.tf and backend.tf in this repository for an example

1. **Include the Module in Your Terraform Configuration**:

   ```hcl
   module "github_aws_federation" {
     source = "./tf_github_aws_federation"  # Adjust the source path as necessary

     organization = "<your-github-organization>"
     repository   = "<your-github-repository>"
   }
   ```

2. **Configure Required Variables**:
   - Replace `<your-github-organization>` and `<your-github-repository>` with your actual GitHub organization and repository names.

3. **Export Github token (AWS Admin)**

  ```bash
  export GITHUB_TOKEN=xxx
  ```

4. **Initialize Terraform (AWS Admin)** (if not already done):

   ```bash
   terraform init
   ```

5. **Apply the Terraform Configuration (AWS Admin)**:

   ```bash
   terraform apply
   ```

## Inputs

- `action-type`: "provision" (default) to create/login or "decommission" to end a lease.
- `aws-access-key-id`: AWS Access Key ID (semi-required).
- `aws-secret-access-key`: AWS Secret Access Key (semi-required).
- `aws-role-arn`: ARN of the AWS IAM role for federated access via GitHub Actions. Use in place of static AWS credentials (semi-required).
- `budget-amount`: Budget amount for the lease (default: '10').
- `budget-currency`: Currency for the budget amount (default: 'USD').
- `email`: Email for notifications.
- `principal-id`: Unique identifier for the principal.
- `expiry`: How long to hold onto the lease (default: '10m').
- `dce-host`: DCE API host (default: 'playground.observe-blunderdome.com').
- `dce-region`: AWS region for DCE (default: 'us-west-2').
- `dce-cli-version`: Version of the DCE CLI to use (default: 'v0.5.0').
- `dce-cli-sha`: SHA256 checksum for the DCE CLI zip (default: provided checksum).

The action must be provided either the aws-role-arn or access key / secret

## Usage

To use this action, add it to your workflow file with the necessary inputs. Here is an example of provisioning a new lease:

```yaml
jobs:
  setup_dce:
    runs-on: ubuntu-latest
    steps:
      - name: Provision DCE Lease
        uses: observeinc/github-action-dce@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          action-type: 'provision'
          email: 'your-email@example.com'
```

For decommissioning a lease:

```yaml
      - name: Decommission DCE Lease
        uses: observeinc/github-action-dce@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          action-type: 'decommission'
```

## Contributing

Contributions to this action are welcome. Please submit issues and pull requests with any suggestions, bug reports, or enhancements.
