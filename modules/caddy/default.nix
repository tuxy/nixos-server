{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ nss ];
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
    };
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
      "whisparr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:6969
        	tls internal
      '';
      "jellyseerr.server01.tuxy.party".extraConfig = ''
                reverse_proxy 127.0.0.1:5055
        	tls internal
      '';
      "sync.server01.tuxy.party".extraConfig = ''
      		reverse_proxy 127.0.0.1:8384 {
			header_up Host {http.reverse_proxy.upstream.hostport}
		}
		tls internal
      '';
    };
  };
}
