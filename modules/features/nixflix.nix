{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nixflix =
    { pkgs, config, ... }:
    {
      imports = [ inputs.nixflix.nixosModules.default ];

      nixflix = {
        enable = true;

        mediaDir = "/data/media";
        downloadsDir = "/data/downloads";
        stateDir = "/data/.state";
        mediaUsers = [ ];

        # jellyfin.enable = true;
        # sonarr.enable = true;
        # radarr.enable = true;
        # lidarr.enable = true;
        # prowlarr.enable = true;
        # seerr.enable = true;
        # flaresolverr.enable = true;
        # recyclarr.enable = true;

        # caddy = {
        #   enable = true;
        #   domain = "media.example.com";
        #   tls.enable = true;
        # };

        # vpn = {
        #   enable = true;
        #   wgConf = config.age.secrets.wireguard.path;
        # };

        # torrentClients = {
        #   transmission.enable = true;
        #   qbittorrent.enable = true;
        # };
      };
    };
}
