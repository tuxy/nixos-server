{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  jav-parser = pkgs.callPackage ./package.nix { };
in
{
  options.services.jav-parser = {
    enable = mkEnableOption "Enable jav-parser";
  };

  config = mkIf config.services.jav-parser.enable {
    systemd.services.jav-parser = {
      description = "jav-parser";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${jav-parser}/bin/jav-parser /data/media/torrents/jav /data/media/library/jav 60 400000000";
        User = "root";
      };
    };
  };
}
