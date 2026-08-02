{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.user =
    {
      pkgs,
      config,
      lib,
      self,
      ...
    }:
    with lib;
    let
      cfg = config.user;
    in
    {
      options.user = {
        root.authorizedKeys = mkOption {
          type = types.listOf types.str;
          default = [ ];
          description = "Authorized SSH keys for the root user";
        };
      };

      config = mkIf (cfg.root.authorizedKeys != [ ]) {
        users.users.root.openssh.authorizedKeys.keys = cfg.root.authorizedKeys;
      };
    };
}