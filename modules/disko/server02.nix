{ lib, ... }: {
  flake.diskoConfigurations.server02 = {
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = "/dev/sda"; # TODO: adjust to actual boot drive (SSD/NVMe)
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                name = "ESP";
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "defaults" ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-L" "nixos" "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = [ "subvol=root" "compress=zstd" "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "subvol=nix" "compress=zstd" "noatime" ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "10G";
                    };
                  };
                };
              };
            };
          };
        };

        # ═══ 5 ZFS drives — pure, GPT partition per disk ═══
        one = {
          type = "disk";
          device = "/dev/disk/by-id/ata-disk-1";
          content = {
            type = "gpt";
            partitions = {
              zfs = {
                size = "100%";
                content = { type = "zfs"; pool = "tank"; };
              };
            };
          };
        };
        two = {
          type = "disk";
          device = "/dev/disk/by-id/ata-disk-2";
          content = {
            type = "gpt";
            partitions = {
              zfs = { size = "100%"; content = { type = "zfs"; pool = "tank"; }; };
            };
          };
        };
        three = {
          type = "disk";
          device = "/dev/disk/by-id/ata-disk-3";
          content = {
            type = "gpt";
            partitions = {
              zfs = { size = "100%"; content = { type = "zfs"; pool = "tank"; }; };
            };
          };
        };
        four = {
          type = "disk";
          device = "/dev/disk/by-id/ata-disk-4";
          content = {
            type = "gpt";
            partitions = {
              zfs = { size = "100%"; content = { type = "zfs"; pool = "tank"; }; };
            };
          };
        };
        five = {
          type = "disk";
          device = "/dev/disk/by-id/ata-disk-5";
          content = {
            type = "gpt";
            partitions = {
              zfs = { size = "100%"; content = { type = "zfs"; pool = "tank"; }; };
            };
          };
        };
      };

      zpool = {
        tank = {
          type = "zpool";
          mode = "raidz2";
          rootFsOptions = {
            compression = "zstd-3";
            atime = "off";
            mountpoint = "none";
          };
          datasets = {
            server01 = {
              type = "zfs_fs";
              mountpoint = "/export/server01";
            };
            server02 = {
              type = "zfs_fs";
              mountpoint = "/export/server02";
            };
          };
        };
      };
    };
  };
}