# clojure-terraform-manager

Terraform configuration manager with home-manager style switch functionality.

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
```

### Samples

See [sample/01_lambda](sample/01_lambda/README.md) for a complete example of deploying an AWS Lambda function

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
