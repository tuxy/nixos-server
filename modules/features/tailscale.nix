{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.tailscale =
    { config, ... }:
    {
      services.tailscale = {
        enable = true;
        authKeyFile = config.age.secrets.tailscale.path;
      };
    };
}

