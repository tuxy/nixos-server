{ ... }:
let
  user = import ../../user/arr.nix { };
in
{
  services.homepage-dashboard.services = [
    {
      "Cloud & Sync" = [
        {
          "Syncthing" = {
            icon = "syncthing.png";
            href = "https://sync.server01.tuxy.party";
            description = "Fast relay server for distributed shares";
          };
        }
        {
          "Nextcloud" = {
            icon = "nextcloud.png";
            href = "https://cloud.server02.tuxy.party";
            description = "Self-hosted personal cloud";
            widget = {
              type = "nextcloud";
              url = "https://cloud.server02.tuxy.party";
              key = "nextcloud_password";
            };
          };
        }
      ];
    }
    {
      "Media" = [
        {
          "Transmission" = {
            icon = "transmission.png";
            href = "https://torrent.server01.tuxy.party";
            description = "P2P File transfer software";
            widget = {
              type = "transmission";
              url = "https://torrent.server01.tuxy.party";
              username = "tuxy";
              password = "";
              rcpUrl = "/transmission/";
            };
          };
        }
        {
          "Jellyfin" = {
            icon = "jellyfin.png";
            href = "https://jellyfin.server01.tuxy.party";
            description = "Personal media library";
            widget = {
              type = "jellyfin";
              url = "https://jellyfin.server01.tuxy.party";
              key = "8c60085736984103abb9a273f287e3a8";
              enableMediaControl = false;
              enableBlocks = true;
              enableNowPlaying = true;
              enableUser = true;
              showEpisodeNumber = true;
            };
          };
        }
        {
          "Jellyseerr" = {
            icon = "jellyseerr.png";
            href = "https://jellyseerr.server01.tuxy.party";
            description = "Request new media";
            widget = {
              type = "jellyseerr";
              url = "https://jellyseerr.server01.tuxy.party";
              key = user.arr.jellyseerr.key;
            };
          };
        }
      ];
    }
    {
      "Arr-stack" = [
        {
          "Radarr" = {
            icon = "radarr.png";
            href = "https://radarr.server01.tuxy.party";
            description = "Movie collection manager";
            widget = {
              type = "radarr";
              url = "https://radarr.server01.tuxy.party";
              key = user.arr.radarr.key;
            };
          };
        }
        {
          "Sonarr" = {
            icon = "sonarr.png";
            href = "https://Sonarr.server01.tuxy.party";
            description = "Show collection manager";
            widget = {
              type = "sonarr";
              url = "https://sonarr.server01.tuxy.party";
              key = user.arr.sonarr.key;
            };
          };
        }
        {
          "Prowlarr" = {
            icon = "prowlarr.png";
            href = "https://prowlarr.server01.tuxy.party";
            description = "Bittorrent/Usenet indexer management";
            widget = {
              type = "prowlarr";
              url = "https://prowlarr.server01.tuxy.party";
              key = user.arr.prowlarr.key;
            };
          };
        }
        {
          "Bazarr" = {
            icon = "bazarr.png";
            href = "https://bazarr.server01.tuxy.party";
            description = "Subtitle retriever for home media";
            widget = {
              type = "bazarr";
              url = "https://bazarr.server01.tuxy.party";
              key = user.arr.bazarr.key;
            };
          };
        }
        {
          "Lidarr" = {
            icon = "lidarr.png";
            href = "https://lidarr.server01.tuxy.party";
            description = "Music collection manager";
            widget = {
              type = "lidarr";
              url = "https://lidarr.server01.tuxy.party";
              key = user.arr.lidarr.key;
            };
          };
        }
      ];
    }
    {
      "Network & Monitoring" = [
        {
          "server01 Proxy" = {
            icon = "nginx.png";
            href = "https://proxy.server01.tuxy.party";
            description = "Reverse proxy WebUI for server01";
            widget = {
              type = "npm";
              url = "https://proxy.server01.tuxy.party";
              username = "admin@tuxy.party";
              password = "proxy_password";
            };
          };
        }
        {
          "server02 Proxy" = {
            icon = "nginx.png";
            href = "https://proxy.server02.tuxy.party";
            description = "Reverse proxy WebUI for server02";
            widget = {
              type = "npm";
              url = "https://proxy.server02.tuxy.party";
              username = "admin@tuxy.party";
              password = "proxy_password";
            };
          };
        }
        {
          "Grafana" = {
            icon = "grafana.png";
            href = "https://graph.server02.tuxy.party";
            description = "Excessive graphical monitoring software";
            widget = {
              type = "grafana";
              version = 2;
              url = "https://graph.server02.tuxy.party";
              username = "admin";
              password = "grafana_password";
            };
          };
        }
      ];
    }
  ];
}
