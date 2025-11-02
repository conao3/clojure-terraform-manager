# sample/01_lambda

Basic example demonstrating how to use terraform-manager. This sample creates a simple AWS Lambda function.

## Prerequisites

- AWS CLI configured (`aws configure`)
- Terraform installed
- terraform-manager built

## Resources

This sample creates the following AWS resources:

- Lambda function (Python 3.12 runtime)
- IAM role for Lambda execution
- Basic execution policy

## Default Configuration File

terraform-manager reads `~/.config/terraform-manager/default.yaml`:

```yaml
terraform_dir: /path/to/clojure-terraform-manager/sample/01_lambda
```

Or specify with absolute path:

```bash
mkdir -p ~/.config/terraform-manager
cat > ~/.config/terraform-manager/default.yaml <<EOF
terraform_dir: $PWD
EOF
```

## Usage

### 1. Using default configuration

```bash
# Create configuration file
mkdir -p ~/.config/terraform-manager
cat > ~/.config/terraform-manager/default.yaml <<EOF
terraform_dir: $(pwd)
EOF

# Dry-run
terraform-manager switch -n

# Execute
terraform-manager switch
```

### 2. Specifying directory via command-line

```bash
# Dry-run
terraform-manager switch -f sample/01_lambda -n

# Execute
terraform-manager switch -f sample/01_lambda
```

### 3. Using Terraform commands directly

```bash
cd sample/01_lambda

# Initialize
terraform init

# Check plan
terraform plan

# Apply
terraform apply

# Destroy
terraform destroy
```

## Customizing Variables

To override variables, create `terraform.tfvars`:

```hcl
aws_region    = "us-east-1"
function_name = "my-custom-function-name"
```

## Expected Output

```
function_arn  = "arn:aws:lambda:ap-northeast-1:123456789012:function:terraform-manager-sample-function"
function_name = "terraform-manager-sample-function"
```

## Cleanup

To destroy created resources:

```bash
cd sample/01_lambda
terraform destroy
```

Or

```bash
terraform-manager destroy -f sample/01_lambda
```

(destroy command to be implemented)
