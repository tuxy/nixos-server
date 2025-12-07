{ ... }:
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "jellyfin.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:8096
        	tls internal
      '';
      "files.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:3923
        	tls internal
      '';
      "torrent.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:9091
        	tls internal
      '';
      "bazarr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:6767
        	tls internal
      '';
      "lidarr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:8686
        	tls internal
      '';
      "prowlarr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:9696
        	tls internal
      '';
      "radarr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:7878
        	tls internal
      '';
      "readarr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:8787
        	tls internal
      '';
      "sonarr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:8989
        	tls internal
      '';
      "jellyseerr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:5055
        	tls internal
      '';
    };
  };
}
