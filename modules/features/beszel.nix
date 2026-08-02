{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.beszel =
    { pkgs, config, self, ... }:
    {
      services.beszel = {
        hub = {
          enable = true;
          settings.port = self.ports.beszel;
          host = "127.0.0.1";
        };
      };
    };
}
