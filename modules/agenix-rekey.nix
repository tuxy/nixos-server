{ self, inputs, ... }: {
  imports = [
    inputs.agenix-rekey.flakeModules.default
  ];

  perSystem = { config, pkgs, ... }: {
    # agenix-rekey.nixosConfigurations defaults to inputs.self.nixosConfigurations
    # (which is the correct value), so we don't need to set it explicitly.

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