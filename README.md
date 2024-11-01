# AWS Key Pair Terraform Module

This Terraform module creates an AWS key pair and generates a corresponding RSA private key,and optionally stores the private key in AWS Secrets Manager using a provided `secretsmanager` module. The key pair can be used to connect to EC2 instances securely.

## Usage

```hcl
module "key_pair" {
  source        = "thomasvjoseph/keypair/aws"
  version       = "1.x.x"
  key_pair_name = "my-key-pair"
  rsa_bits      = 2048  # Optional, defaults to 4096
}

# Optional: Store the private key in AWS Secrets Manager
module "secretsmanager" {
  source              = "./modules/secretsmanager"    # Path to the Secrets Manager module
  secretsmanager_name = "my-private-key-secret"       # Name for the secret
  secrets_value       = module.aws_keypair.private_key_value # Private key value from keypair output
}
```

This module will create an AWS key pair using the provided `key_pair_name` and generate an RSA private key with the specified `rsa_bits`.

## Resources

- `aws_key_pair` – Creates an AWS EC2 Key Pair.
- `tls_private_key` – Generates a private key with the provided RSA bits.
- `local_file` – Writes the private key to a `.pem` file on your local system.
- `secretsmanager` (optional) – Stores the private key in AWS Secrets Manager if configured.

## Inputs

| Name                  | Description                           | Type     | Default | Required |
|-----------------------|---------------------------------------|----------|---------|----------|
| `key_pair_name`       | The name of the AWS key pair          | `string` | n/a     | yes      |
| `rsa_bits`            | Number of bits for RSA key generation | `number` | 4096    | no       |
| `secretsmanager_name` | Name for the secret in Secrets Manager| `string` | n/a     | yes      |
| `description`         | Value for the secret in Secrets Manager| `string`| n/a     | no       |

## Outputs

| Name               | Description                          |
|--------------------|--------------------------------------|
| `key_pair_name`    | The name of the generated key pair   |
| `private_key_path` | The path to the private key file     |
| `private_key_value`| The path to the private key file     |
| `secret_id`        | The ARN of the secret in Secrets Manager |


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