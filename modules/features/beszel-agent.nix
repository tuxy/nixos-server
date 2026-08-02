{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.beszel-agent =
    { pkgs, config, self, ... }:
    {
      services.beszel.agent = {
        enable = true;
        openFirewall = false;
        environment = {
          HUB_URL = "https://${self.domains.beszel}.server02.${self.domains.base}";
        };
        environmentFile = config.age.secrets.beszel-agent-env.path;
      };
    };
}