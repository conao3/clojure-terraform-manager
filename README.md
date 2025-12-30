# clojure-terraform-manager

A Terraform configuration manager written in Clojure, inspired by home-manager's declarative switch functionality.

## Overview

This tool provides a streamlined way to manage and apply Terraform configurations with a simple command-line interface. It compiles to a native binary using GraalVM for fast startup times and minimal resource usage.

## Requirements

- Clojure 1.12+
- GraalVM (for native compilation)

## Installation

### From Source

```bash
git clone https://github.com/conao3/clojure-terraform-manager.git
cd clojure-terraform-manager
make native
```

The compiled binary will be available at `target/terraform-manager`.

## Usage

```bash
terraform-manager switch
```

## Development

This project uses standard Clojure tooling with `deps.edn` and Make for build automation.

### Start REPL

```bash
make repl
```

Launches an nREPL server with CIDER middleware for interactive development.

### Run Tests

```bash
make test
```

### Build

```bash
# Build uber JAR
make uber

# Build native binary
make native
```

### Update Dependencies

```bash
make update
```

## License

This project is open source.
