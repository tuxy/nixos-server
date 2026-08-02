{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.ci =
    {
      pkgs,
      config,
      self,
      ...
    }:
    {
      imports = [
        inputs.gachix.nixosModules.default
        inputs.hydra.nixosModules.hydra
      ];

      services.gachix = {
        enable = true;
        port = self.ports.gachix;
        openFirewall = true;
        settings = {
          store = {
            use_local_nix_daemon = true;
            path = "/var/lib/gachix/cache";
            remotes = [ ];
            sign_private_key_path = "/run/gachix/cache.secret";
          };
        };
      };

      services.hydra = {
        enable = true;
        hydraURL = "https://${self.domains.hydra}";
        notificationSender = "hydra@${self.domains.base}";
        buildUser = "hydra-queue-runner";
      };
    };
}
