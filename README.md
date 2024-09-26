Here's a sample `README.md` file for your Terraform module:

```markdown
# AWS Key Pair Terraform Module

This Terraform module creates an AWS key pair and generates a corresponding RSA private key. The key pair can be used to connect to EC2 instances securely.

## Usage

```hcl
module "key_pair" {
  source        = "your-terraform-registry-namespace/key-pair/aws"
  key_pair_name = "my-key-pair"
  rsa_bits      = 2048  # Optional, defaults to 4096
}
```

This module will create an AWS key pair using the provided `key_pair_name` and generate an RSA private key with the specified `rsa_bits`.

## Resources

- `aws_key_pair` – Creates an AWS EC2 Key Pair.
- `tls_private_key` – Generates a private key with the provided RSA bits.
- `local_file` – Writes the private key to a `.pem` file on your local system.

## Inputs

| Name            | Description                          | Type     | Default | Required |
|-----------------|--------------------------------------|----------|---------|----------|
| `key_pair_name` | The name of the AWS key pair         | `string` | n/a     | yes      |
| `rsa_bits`      | Number of bits for RSA key generation | `number` | 4096    | no       |

## Outputs

None.

## Example

```hcl
module "my_key_pair" {
  source        = "your-terraform-registry-namespace/key-pair/aws"
  key_pair_name = "my-new-key"
  rsa_bits      = 2048
}
```

After applying the Terraform configuration, the private key will be saved as `my-new-key.pem` in your working directory.

## License

MIT License
```

Replace `your-terraform-registry-namespace` with your actual Terraform Registry namespace. This `README.md` will provide clarity on how to use the module when you push it to the Terraform Registry.