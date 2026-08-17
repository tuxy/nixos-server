{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.immich =
    {
      pkgs,
      config,
      lib,
      self,
      ...
    }:
    with lib;
    let
      cfg = config.immich;
      hostName = config.networking.hostName;
      baseDomain = self.domains.base;
      immichDomain = "${self.domains.immich}.${hostName}.${baseDomain}";
    in
    {
      options.immich = {
        enable = mkEnableOption "Immich photo management with public proxy and Cloudflare Tunnel";

        mediaLocation = mkOption {
          type = types.path;
          default = "/data/immich";
          description = "Directory to store Immich media files.";
        };

        publicProxy = {
          enable = mkEnableOption "Immich Public Proxy for sharing albums publicly";

          port = mkOption {
            type = types.port;
            default = 3000;
            description = "Port for the public proxy to listen on.";
          };
        };

        cloudflareTunnel = {
          enable = mkEnableOption "Cloudflare Tunnel for Immich Public Proxy";

          tunnelId = mkOption {
            type = types.str;
            description = "Cloudflare Tunnel ID (UUID).";
          };

          domain = mkOption {
            type = types.str;
            description = "Domain to route through the tunnel (e.g. 'photos.example.com').";
          };
        };

        accelerationDevices = mkOption {
          type = types.nullOr (types.listOf types.str);
          default = null;
          description = ''
            List of hardware acceleration device paths to mount into the Immich container.
            Set to null to mount all /dev/dri devices (e.g. /dev/dri/renderD128, /dev/dri/card0).
          '';
        };
      };

      config = mkIf cfg.enable {
        # Immich
        services.immich = {
          enable = true;
          host = "127.0.0.1";
          port = self.ports.immich;
          mediaLocation = cfg.mediaLocation;
          openFirewall = false;
          accelerationDevices =
            if cfg.accelerationDevices != null then cfg.accelerationDevices else [ "/dev/dri" ];
          settings = {
            server.externalDomain = "https://${immichDomain}";
          };
        };

        environment.systemPackages = [ pkgs.immich-go ];

        users.users.immich.extraGroups = [
          "media"
          "video"
          "render"
        ];

        # Immich album sharing proxy
        services.immich-public-proxy = mkIf cfg.publicProxy.enable {
          enable = true;
          immichUrl = "http://127.0.0.1:${toString self.ports.immich}";
          port = cfg.publicProxy.port;
          openFirewall = false;
        };

        # Cloudflare Tunnels
        services.cloudflared = mkIf (cfg.cloudflareTunnel.enable && cfg.publicProxy.enable) {
          enable = true;
          tunnels = {
            "${cfg.cloudflareTunnel.tunnelId}" = {
              credentialsFile = config.age.secrets.cloudflare-tunnel.path;
              ingress = {
                "${cfg.cloudflareTunnel.domain}" = {
                  service = "http://127.0.0.1:${toString cfg.publicProxy.port}";
                };
              };
              default = "http_status:404";
            };
          };
        };

        services.redis.servers.immich.logLevel = "warning";
      };
    };
}
