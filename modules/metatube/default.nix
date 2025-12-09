{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  metatube-server = pkgs.callPackage ./package.nix { };
in
{
  options.services.metatube-server = {
    enable = mkEnableOption "Enable metatube-server";
  };

  config = mkIf config.services.metatube-server.enable {
    systemd.services.metatube-server = {
      description = "metatube-server";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${metatube-server}/bin/metatube-server";
        User = "root";
      };
    };
  };
}
