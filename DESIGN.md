# terraform-manager Design

## Overview

terraform-manager is a Terraform configuration manager inspired by home-manager. It allows users to define infrastructure in Nix language (using terranix) and deploy with a simple `switch` command.

## Architecture

### Configuration Flow

```
config.nix (Nix)
    ↓ (terranix)
config.tf.json (Terraform JSON)
    ↓ (terraform)
Deployed Infrastructure
```

### Command Flow

```
terraform-manager switch
    ↓
Read ~/.config/terraform-manager/default.yaml
    ↓
If nix_file specified:
    ↓
    terranix config.nix > config.tf.json
    ↓
terraform init
    ↓
terraform apply (or plan if -n flag)
```

## Configuration File Format

YAML format at `~/.config/terraform-manager/default.yaml`:

```yaml
terraform_dir: /path/to/terraform/dir
nix_file: config.nix  # optional, enables terranix conversion
```

### Fields

- `terraform_dir`: Directory containing Terraform/Nix configuration (required)
- `nix_file`: Nix file to convert to Terraform JSON (optional)
  - If specified: Uses terranix to convert Nix → Terraform JSON
  - If omitted: Uses existing .tf or .tf.json files directly

## Command-Line Interface

### switch command

```bash
terraform-manager switch [OPTIONS]
```

Options:
- `-f, --file DIR`: Specify terraform directory (overrides config file)
- `-n, --dry-run`: Run terraform plan instead of apply
- `-v, --verbose`: Show detailed output
- `--help`: Show help message

### Future commands

- `terraform-manager build`: Generate config.tf.json without applying
- `terraform-manager destroy`: Destroy infrastructure
- `terraform-manager rollback`: Rollback to previous generation

## Implementation Plan

### Phase 1: Basic Switch (Current)
- [x] Project setup
- [x] Sample with Nix/terranix
- [ ] YAML config parsing
- [ ] terranix integration
- [ ] terraform execution

### Phase 2: CLI Options
- [ ] -f flag for directory override
- [ ] -n flag for dry-run (plan only)
- [ ] -v flag for verbose output

### Phase 3: Advanced Features
- [ ] Generation tracking (like home-manager)
- [ ] Rollback support
- [ ] Multiple profiles
- [ ] State management

## Dependencies

### Runtime
- Nix (for terranix evaluation)
- terranix (for Nix → Terraform conversion)
- terraform (for infrastructure deployment)
- clj-yaml (for YAML parsing)

### Build
- Clojure 1.12.2+
- tools.build
- GraalVM (for native binary)

## File Structure

```
~/.config/terraform-manager/
├── default.yaml          # Main configuration
└── profiles/             # Future: Multiple profiles
    ├── dev.yaml
    └── prod.yaml

/path/to/project/
├── config.nix            # Infrastructure in Nix
├── flake.nix             # Nix flake (optional)
├── config.tf.json        # Generated Terraform (ignored in git)
└── .terraform/           # Terraform state
```

## Error Handling

1. **Missing terranix**: If nix_file specified but terranix not available
   - Error: "terranix not found. Please install via: nix profile install nixpkgs#terranix"

2. **Invalid Nix syntax**: If config.nix has syntax errors
   - Show terranix error output
   - Exit with error code

3. **Terraform errors**: If terraform init/plan/apply fails
   - Show terraform output
   - Exit with terraform's exit code

4. **Missing config file**: If default.yaml doesn't exist and -f not specified
   - Error: "No configuration found. Create ~/.config/terraform-manager/default.yaml or use -f flag"

## Testing Strategy

1. **Unit tests**: YAML parsing, config validation
2. **Integration tests**: terranix conversion, terraform execution
3. **E2E tests**: Full switch workflow with sample/01_lambda
