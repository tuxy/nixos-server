{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

{
  options.services.wireproxy = {
    enable = mkEnableOption "Enable wireproxy service";
    configPath = mkOption {
      type = lib.types.str;
      default = "";
      description = "Path to wireproxy config file";
    };
  };

  config = mkIf config.services.wireproxy.enable {
    systemd.services.wireproxy = {
      description = "wireproxy";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.wireproxy}/bin/wireproxy -c ${config.services.wireproxy.configPath}";
        User = "root";
      };
    };
  };
}
