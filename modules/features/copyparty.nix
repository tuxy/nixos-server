{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.copyparty =
    {
      pkgs,
      config,
      self,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.copyparty ];

      services.copyparty = {
        enable = true;
        settings.i = "127.0.0.1";
        settings.p = self.ports.copyparty;
      };
    };
}
