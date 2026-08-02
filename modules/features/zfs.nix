{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.zfs =
    { config, lib, ... }:
    with lib;
    let
      cfg = config.zfs;
    in
    {
      options.zfs = {
        poolName = mkOption {
          type = types.str;
          default = "tank";
        };

        drives = mkOption {
          type = types.listOf types.str;
          default = [ ];
        };

        datasets = mkOption {
          type = types.attrsOf (
            types.submodule {
              options = {
                mountPoint = mkOption {
                  type = types.str;
                };
                nfsExport = mkOption {
                  type = types.nullOr types.str;
                  default = null;
                };
                compression = mkOption {
                  type = types.str;
                  default = "zstd-3";
                };
                atime = mkOption {
                  type = types.enum [
                    "on"
                    "off"
                  ];
                  default = "off";
                };
              };
            }
          );
          default = { };
        };

        symlinks = mkOption {
          type = types.attrsOf types.str;
          default = { };
          description = "Symlinks to create: { target = source; }";
        };
      };

      config = mkIf (cfg.datasets != { }) {
        boot.supportedFilesystems = [ "zfs" ];
        boot.zfs.devNodes = mkDefault "/dev/disk/by-id/";
        services.zfs.autoScrub.enable = true;
        networking.hostId = builtins.substring 0 8 (
          builtins.hashString "sha256" config.networking.hostName
        );

        systemd.tmpfiles.rules = mapAttrsToList (
          target: source: "L ${target} - - - - ${source}"
        ) cfg.symlinks;

        networking.firewall.allowedTCPPorts =
          mkIf (any (ds: ds.nfsExport != null) (attrValues cfg.datasets))
            [
              111
              2049
              20048
            ];
        networking.firewall.allowedUDPPorts =
          mkIf (any (ds: ds.nfsExport != null) (attrValues cfg.datasets))
            [
              111
              2049
              20048
            ];

        services.nfs.server = mkIf (any (ds: ds.nfsExport != null) (attrValues cfg.datasets)) {
          enable = true;
          exports = concatStringsSep "\n" (
            mapAttrsToList (name: ds: "${ds.mountPoint} ${ds.nfsExport}") (
              filterAttrs (name: ds: ds.nfsExport != null) cfg.datasets
            )
          );
        };
      };
    };
}
