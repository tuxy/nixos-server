{ self, inputs, ... }: {
  imports = [
    inputs.agenix-rekey.flakeModules.default
  ];

  perSystem = { config, pkgs, ... }: {
    agenix-rekey.nixosConfigurations = config.flake.nixosConfigurations;

    # Expose the agenix CLI wrapper as a package and app:
    #   nix run .#agenix -- edit secrets/foo.age
    #   nix run .#agenix -- rekey
    packages.agenix = config.agenix-rekey.package;

    apps.agenix = {
      type = "app";
      program = "${config.agenix-rekey.package}/bin/agenix";
    };
  };
}