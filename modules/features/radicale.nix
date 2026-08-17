{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.radicale =
    {
      pkgs,
      config,
      self,
      ...
    }:
    {
      services.radicale = {
        enable = true;
        settings = {
          server = {
            hosts = [ "127.0.0.1:${toString self.ports.radicale}" ];
          };
          auth = {
            type = "htpasswd";
            htpasswd_filename = config.age.secrets.radicale.path;
            htpasswd_encryption = "bcrypt";
          };
          storage = {
            filesystem_folder = "/data/radicale";
          };
        };
      };
    };
}
