{ config, ... }:
{
  age.secrets.wgconf.file = ../../secrets/wgconf.age;
  age.identityPaths = [ "/root/.ssh/id_rsa" ];

  nixarr = {
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
    };

    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    readarr.enable = true;
    sonarr.enable = true;
    jellyseerr.enable = true;
  };
}
