# clojure-terraform-manager

Terraform configuration manager with home-manager style switch functionality. Define your infrastructure in Nix language using terranix, then deploy with a single command.

## Usage

### Basic Usage

```bash
# Use default configuration from ~/.config/terraform-manager/default.yaml
terraform-manager switch

# Specify terraform directory
terraform-manager switch -f /path/to/terraform/dir

# Dry-run (terraform plan only)
terraform-manager switch -n

# Verbose output
terraform-manager switch -v
```

### Configuration File

Create `~/.config/terraform-manager/default.yaml`:

```yaml
terraform_dir: /path/to/terraform/dir
nix_file: config.nix  # optional, uses terranix to convert Nix to Terraform
```

### Samples

See [sample/01_lambda](sample/01_lambda/README.md) for a complete example of deploying an AWS Lambda function using Nix/terranix

## Features

- **Nix-based Configuration**: Write infrastructure as code using Nix language via terranix
- **home-manager Style**: Familiar interface for NixOS users
- **Automatic Conversion**: Converts Nix to Terraform JSON automatically
- **Type Safety**: Leverage Nix's type system for infrastructure definitions
- **Reproducible**: Nix ensures consistent deployments across environments

## Development

```bash
# Start REPL
make repl

# Run tests
make test

# Build uber jar
make uber

# Build native binary
make native
```
