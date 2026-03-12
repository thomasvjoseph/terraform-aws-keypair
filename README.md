# AWS Key Pair Terraform Module

This Terraform project generates an AWS EC2 key pair along with a locally‑saved PEM file.  The private key may be written to AWS Secrets Manager for safekeeping, and an optional IAM user can be created with programmatic access; its credentials are also stored in Secrets Manager.

## Usage

```hcl
module "key_pair" {
  source        = "thomasvjoseph/keypair/aws"
  version       = "1.x.x"
  key_pair_name = "my-key-pair"
  rsa_bits      = 2048  # Optional, defaults to 4096
}

# Optional: store the PEM in Secrets Manager
module "secretsmanager" {
  source              = "./modules/secretsmanager"    # local path in this repo
  secretsmanager_name = "my-private-key-secret"       # must not be empty to enable module
  description         = "Private SSH key for my EC2 instances"
  secrets_value       = tls_private_key.rsa.private_key_pem
  tags                = { Environment = "dev" }
}

# Optional: create an IAM user whose access keys are saved to a secret
module "iam_user" {
  source              = "./modules/iam"
  user_name           = "terraform-user"
  secretsmanager_name = "terraform-user-credentials"
  tags                = { Environment = "dev" }
}
```

When the `secretsmanager_name` or `iam_user_name` variables are left blank, the corresponding submodule is skipped.

## Modules

* `secretsmanager` – wrapper around `aws_secretsmanager_secret`/`aws_secretsmanager_secret_version` with support for sensitive inputs and optional KMS key.
* `iam` – creates an IAM user, access key, grants it broad Secrets Manager read/write permissions and writes the credentials to a designated secret.


This module will create an AWS key pair using the provided `key_pair_name` and generate an RSA private key with the specified `rsa_bits`.

## Resources

- `aws_key_pair` – Creates an AWS EC2 Key Pair.
- `tls_private_key` – Generates a private key with the provided RSA bits.
- `local_file` – Writes the private key to a `.pem` file on your local system.
- `secretsmanager` (optional) – Stores the private key in AWS Secrets Manager if configured.

## Inputs

| Name                  | Description                                                                  | Type     | Default | Required |
|-----------------------|------------------------------------------------------------------------------|----------|---------|----------|
| `key_pair_name`       | The name of the AWS key pair                                                 | `string` | n/a     | yes      |
| `rsa_bits`            | Number of bits for RSA key generation                                        | `number` | 4096    | no       |
| `secretsmanager_name` | (optional) name for the SSH private key secret; leave blank to skip creation| `string` | ""     | no       |
| `secrets_description` | Description applied to the SSH key secret                                   | `string` | "SSH private key stored by Terraform" | no |
| `iam_user_name`       | (optional) IAM username to create; leave blank to skip creation             | `string` | ""     | no       |
| `iam_secrets_name`    | (optional) name for the secret that will hold the IAM user's access keys    | `string` | ""     | no       |
| `iam_tags`            | Tags to apply to both Secrets Manager resources and the IAM user            | `map(string)` | `{}` | no |

## Outputs

| Name                        | Description                                                |
|-----------------------------|------------------------------------------------------------|
| `key_pair_name`             | The name of the generated key pair                         |
| `private_key_path`          | The path to the private key file on the local filesystem   |
| `private_key_value`         | Raw private key material (sensitive)                       |
| `ssh_secret_id`             | ID of the Secrets Manager secret holding the SSH key       |
| `ssh_secret_arn`            | ARN of the SSH key secret                                  |
| `iam_user_arn`              | ARN of the optional IAM user created                       |
| `iam_credentials_secret_id` | ID of the secret containing IAM access keys (if created)   |


After applying the Terraform configuration, the private key will be saved via any CI/CD pipeline `my-new-key.pem` 
example github actions:

## Examples
```yml
    - name: Upload PEM file
        if: contains(github.event.head_commit.message, 'keypair')
        uses: actions/upload-artifact@v4
        with:
          name: pem-file
          path: environments/dev/hello-module.pem #specify the path name and key file name
```
## License

This module is licensed under the MIT License.

## Author:  
thomas joseph
- [linkedin](https://www.linkedin.com/in/thomas-joseph-88792b132/)
- [medium](https://medium.com/@thomasvjoseph)