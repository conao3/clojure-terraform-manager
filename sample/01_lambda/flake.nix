{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, terranix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        terraform = pkgs.terraform;
        terraformConfiguration = terranix.lib.terranixConfiguration {
          inherit system;
          modules = [ ./config.nix ];
        };
      in
      {
        packages.default = terraformConfiguration;

        devShells.default = pkgs.mkShell {
          buildInputs = [
            terraform
            terranix.defaultPackage.${system}
          ];
        };

        apps = {
          apply = {
            type = "app";
            program = toString (pkgs.writers.writeBash "apply" ''
              set -euo pipefail
              if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
              cp ${terraformConfiguration} config.tf.json
              ${terraform}/bin/terraform init
              ${terraform}/bin/terraform apply
            '');
          };

          plan = {
            type = "app";
            program = toString (pkgs.writers.writeBash "plan" ''
              set -euo pipefail
              if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
              cp ${terraformConfiguration} config.tf.json
              ${terraform}/bin/terraform init
              ${terraform}/bin/terraform plan
            '');
          };

          destroy = {
            type = "app";
            program = toString (pkgs.writers.writeBash "destroy" ''
              set -euo pipefail
              if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
              cp ${terraformConfiguration} config.tf.json
              ${terraform}/bin/terraform init
              ${terraform}/bin/terraform destroy
            '');
          };

          default = self.apps.${system}.apply;
        };
      });
}
