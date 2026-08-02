{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.ntfy =
    { pkgs, config, self, ... }:
    {
      services.ntfy-sh = {
        enable = true;
        settings = {
          listen-http = "127.0.0.1:${toString self.ports.ntfy}";
          base-url = "https://${self.domains.ntfy}.${config.networking.hostName}.${self.domains.base}";
          cache-file = "/data/.state/ntfy/cache.db";
          auth-file = "/data/.state/ntfy/auth.db";
        };
      };
    };
}