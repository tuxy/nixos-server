{ config, pkgs, ... }:
{
  imports = [
    ../../modules/wireproxy/default.nix
  ];

  age.secrets.wgconf.file = ../../secrets/wg.conf.age;
  age.secrets.wgproxyconf.file = ../../secrets/wgproxy.conf.age;
  age.identityPaths = [ "/root/.ssh/id_rsa" ];

  services.wireproxy = {
    enable = true;
    configPath = config.age.secrets.wgproxyconf.path;
  };

  hardware.graphics = {
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
      extraSettings = {
        rpc-authentication-required = "true";
        rpc-username = "tuxy";
	port-forwarding-enabled = "true";
	ratio-limit = "5";
	ratio-limit-enabled = "true";
      };
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
