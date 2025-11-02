# sample/01_lambda

Basic example demonstrating how to use terraform-manager with Nix/terranix. This sample creates a simple AWS Lambda function using Nix language that gets converted to Terraform.

## Prerequisites

- Nix with flakes enabled
- AWS CLI configured (`aws configure`)
- terraform-manager built (for future use)

## Resources

This sample creates the following AWS resources:

- Lambda function (Python 3.12 runtime)
- IAM role for Lambda execution
- Basic execution policy

## Configuration

The infrastructure is defined in `config.nix` using Nix language (terranix). This gets converted to Terraform JSON at build time.

## Usage

### 1. Using Nix Flakes (Recommended)

```bash
cd sample/01_lambda

# Check what will be created (dry-run)
nix run ".#plan"

# Deploy the infrastructure
nix run ".#apply"

# Destroy the infrastructure
nix run ".#destroy"
```

### 2. Using terraform-manager (Future)

Create `~/.config/terraform-manager/default.yaml`:

```yaml
terraform_dir: /path/to/clojure-terraform-manager/sample/01_lambda
nix_file: config.nix
```

Then run:

```bash
# Dry-run
terraform-manager switch -n

# Execute
terraform-manager switch
```

### 3. Manual Conversion and Apply

```bash
cd sample/01_lambda

# Enter development shell
nix develop

# Generate Terraform JSON from Nix
terranix config.nix > config.tf.json

# Initialize Terraform
terraform init

# Check plan
terraform plan

# Apply
terraform apply

# Destroy
terraform destroy
```

## Development

Enter the development shell to get terraform and terranix:

```bash
nix develop
```

Build the Terraform JSON configuration:

```bash
nix build
cat result
```

## Customizing Variables

To override variables, you can modify `config.nix` or create a separate `variables.nix` file and import it.

## Expected Output

```
function_arn  = "arn:aws:lambda:ap-northeast-1:123456789012:function:terraform-manager-sample-function"
function_name = "terraform-manager-sample-function"
```

## Why Nix/terranix?

Using Nix language for Terraform provides several benefits:

- **Type safety**: Nix's type system catches errors early
- **Modularity**: Easy to split configurations into reusable modules
- **Composition**: Import and compose multiple configuration files
- **Functions**: Use Nix functions to reduce duplication
- **Reproducibility**: Nix ensures consistent builds across environments

## File Structure

- `config.nix` - Infrastructure definition in Nix language
- `flake.nix` - Nix flake for building and deploying
- `.gitignore` - Ignore generated files
