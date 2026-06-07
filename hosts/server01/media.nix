{ pkgs, config, ... }:
{
  imports = [
    ../../modules/wireproxy
    ../../modules/metatube
    ../../modules/jav-parser
  ];

  services.wireproxy = {
    enable = true;
    configPath = config.age.secrets.wgproxyconf.path;
  };

  services.jav-parser = {
    enable = true;
    sourcePath = "/data/media/torrents/jav";
    destPath = "/data/media/library/jav";
  };

  services.jellyfin = {
    enable = true;
    group = "media";
    cacheDir = "/data/media/.state/nixarr/jellyfin/cache";
    logDir = "/data/media/.state/nixarr/jellyfin/log";
    configDir = "/data/media/.state/nixarr/jellyfin/config";
    dataDir = "/data/media/.state/nixarr/jellyfin/data";
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  services.avahi.enable = true;
  networking.firewall.allowedUDPPorts = [ 1900 ];

  services.flaresolverr.enable = true;
  services.metatube-server.enable = true;

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0 0 * * *	root	'find /data/media/torrents >> /data/media/.file-lists/list-$(date -u +%F).txt'"
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

    # jellyfin.enable = true;
    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 47283;
      flood.enable = true;
      extraSettings = {
        rpc-authentication-required = "true";
        rpc-username = "tuxy";
        port-forwarding-enabled = "true";
        ratio-limit = "5";
        ratio-limit-enabled = "true";
      };
    };

    qbittorrent = {
      enable = true;
      vpn.enable = true;
      peerPort = 51234;
      qui.enable = true;
      extraConfig = {
        LegalNotice = {
          Accepted = true;
        };
        Preferences = {
          WebUI = {
            Username = "tuxy";
            Password_PBKDF2 = "@ByteArray()";
          };
        };
      };
    };

    bazarr.enable = true;
    lidarr.enable = true;
    prowlarr.enable = true;
    whisparr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    jellyseerr.enable = true;
  };
}
