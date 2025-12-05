{
  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixarr.url = "github:rasmus-kirk/nixarr";
    copyparty.url = "github:9001/copyparty";
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    {
      nixpkgs,
      copyparty,
      disko,
      agenix,
      nixarr,
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
            nixarr.nixosModules.default
            agenix.nixosModules.default
            ./hosts/server01/configuration.nix
            ./hardware-configuration.nix
          ];
        };
        server02 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/server02/configuration.nix
            ./hardware-configuration.nix
          ];
        };
      };
    };
}
