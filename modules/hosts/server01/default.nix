{ self, inputs, ... }: {
  flake.nixosConfigurations.server01 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs self; };
    modules = [
      inputs.agenix.nixosModules.default
      inputs.agenix-rekey.nixosModules.default
      inputs.disko.nixosModules.disko
      self.nixosModules.server01Configuration
      self.nixosModules.server01Hardware
    ];
  };
}
