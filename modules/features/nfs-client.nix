{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.nfs-client =
    { config, lib, ... }:
    with lib;
    let
      cfg = config.nfs;
    in
    {
      options.nfs = {
        mounts = mkOption {
          type = types.attrsOf (types.submodule {
            options = {
              server = mkOption {
                type = types.str;
              };
              export = mkOption {
                type = types.str;
              };
              mountPoint = mkOption {
                type = types.str;
              };
              options = mkOption {
                type = types.listOf types.str;
                default = [ "vers=4.2" "noatime" "_netdev" ];
              };
            };
          });
          default = { };
        };
      };

      config = mkIf (cfg.mounts != { }) {
        fileSystems = mapAttrs' (name: mnt:
          nameValuePair mnt.mountPoint {
            device = "${mnt.server}:${mnt.export}";
            fsType = "nfs";
            options = mnt.options;
          }
        ) cfg.mounts;
      };
    };
}
