{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.disko.url = "github:nix-community/disko";
  inputs.copyparty.url = "github:9001/copyparty";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs =
    {
      nixpkgs,
      copyparty,
      disko,
      ...
    }:
    {
      # Use this for all other targets
      # nixos-anywhere --flake .#{server01,server02} --generate-hardware-config nixos-generate-config ./hardware-configuration.nix <hostname>
      nixosConfigurations = {
        server01 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            copyparty.nixosModules.default
            ./modules/user
            ./hosts/server01/configuration.nix
            ./hardware-configuration.nix
          ];
        };
        server02 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./modules/user
            ./hosts/server02/configuration.nix
            ./hardware-configuration.nix
          ];
        };
      };
    };
}
