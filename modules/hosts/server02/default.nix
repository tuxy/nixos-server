{ self, inputs, ... }: {
  flake.nixosConfigurations.server02 = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs self; };
    modules = [
      inputs.agenix.nixosModules.default
      inputs.agenix-rekey.nixosModules.default
      inputs.disko.nixosModules.disko
      self.nixosModules.server02Configuration
      self.nixosModules.server02Hardware
    ];
  };
}
