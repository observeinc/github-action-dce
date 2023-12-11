# DCE Environment Setup and Login GitHub Action

This GitHub Action provisions or decommissions a Dynamic Cloud Environment (DCE) lease. It is designed to create an ephemeral AWS account with a specified budget and duration or to clean up the lease after use.

## Terraform Module for AWS/GitHub Federation

To facilitate the setup of AWS/GitHub federation for this GitHub Action, we have provided a dedicated Terraform module. This module simplifies the process of setting up the necessary AWS IAM roles and policies, and integrating them with GitHub Actions.

For detailed information on how to use this module, including configuration options and usage examples, please refer to the module's [tf_github_aws_federation/README.md](README.md).

## Inputs

- `action-type`: "provision" (default) to create/login or "decommission" to end a lease.
- `aws-access-key-id`: AWS Access Key ID (required).
- `aws-secret-access-key`: AWS Secret Access Key (required).
- `budget-amount`: Budget amount for the lease (default: '10').
- `budget-currency`: Currency for the budget amount (default: 'USD').
- `email`: Email for notifications.
- `principal-id`: Unique identifier for the principal.
- `expiry`: How long to hold onto the lease (default: '10m').
- `dce-host`: DCE API host (default: 'playground.observe-blunderdome.com').
- `dce-region`: AWS region for DCE (default: 'us-west-2').
- `dce-cli-version`: Version of the DCE CLI to use (default: 'v0.5.0').
- `dce-cli-sha`: SHA256 checksum for the DCE CLI zip (default: provided checksum).

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
