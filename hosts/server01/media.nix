{ config, pkgs, ... }:
{
  age.secrets.wgconf.file = ../../secrets/wg.conf.age;
  age.identityPaths = [ "/root/.ssh/id_rsa" ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };

  nixarr = {
    enable = true;

    vpn = {
      enable = true;
      wgConf = config.age.secrets.wgconf.path;
    };
    mediaDir = "/data/media";
    stateDir = "/data/media/.state/nixarr";

    jellyfin.enable = true;
    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 47283;
      flood.enable = true;
    };

    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    sonarr.enable = true;
    jellyseerr.enable = true;
  };

  # Necessary fix for bazarr
  systemd.services.radarr = {
    serviceConfig = {
      UMask = "0002";
    };
  };

  systemd.services.sonarr = {
    serviceConfig = {
      UMask = "0002";
    };
  };

  systemd.services.bazarr = {
    serviceConfig = {
      UMask = "0002";
    };
  };
}
