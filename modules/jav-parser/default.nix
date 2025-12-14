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
    sourcePath = mkOption {
      type = lib.types.str;
      default = "";
    };
    destPath = mkOption {
      type = lib.types.str;
      default = "";
    };
    interval = mkOption {
      type = lib.types.int;
      default = 20;
    };
    minSize = mkOption {
      type = lib.types.int;
      default = 400000000;
    };
  };

  config = mkIf config.services.jav-parser.enable {
    systemd.services.jav-parser = {
      description = "jav-parser";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${jav-parser}/bin/jav-parser ${config.services.jav-parser.sourcePath} ${config.services.jav-parser.destPath} ${builtins.toString config.services.jav-parser.interval} ${builtins.toString config.services.jav-parser.minSize}";
        User = "root";
      };
    };
  };
}
