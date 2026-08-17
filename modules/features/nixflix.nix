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

        sonarr.enable = true;
        radarr.enable = true;
        lidarr.enable = true;
        prowlarr.enable = true;
        seerr.enable = true;
        jellyfin.enable = true;
        flaresolverr.enable = true;
        recyclarr.enable = true;

        torrentClients = {
          qbittorrent.enable = true;
        };

        sonarr.config.hostConfig.bindAddress = "127.0.0.1";
        radarr.config.hostConfig.bindAddress = "127.0.0.1";
        prowlarr.config.hostConfig.bindAddress = "127.0.0.1";

        # No auth
        sonarr.config.hostConfig.username = null;
        sonarr.config.hostConfig.password = null;
        radarr.config.hostConfig.username = null;
        radarr.config.hostConfig.password = null;
        lidarr.config.hostConfig.username = null;
        lidarr.config.hostConfig.password = null;
        prowlarr.config.hostConfig.username = null;
        prowlarr.config.hostConfig.password = null;

        sonarr.config.apiKey = "5ba727015bcdcc1f6abc61fd5c863046";
        radarr.config.apiKey = "ff1640d5fa8f091d17852c1d2ec7cbbe";
        lidarr.config.apiKey = "770d40fc11e3422b95468f527c2cdb16";
        prowlarr.config.apiKey = "16e3a63527562fe8e5d221a070a5936a";
        jellyfin.apiKey = "adabdec5a3570fed24695c743f88da54";
        seerr.apiKey = "90f1ad98f04aaccb05e284d86d59fd65";

        jellyfin.users = {
          admin = {
            password = "changeme";
            policy = {
              isAdministrator = true;
            };
          };
        };

        torrentClients.qbittorrent.serverConfig = {
          Preferences.WebUI.Address = "127.0.0.1";
        };
      };
    };
}

