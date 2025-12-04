{ }:
{
  services.caddy = {
    enable = true;
    virtualHosts = {
      "media.server01.tuxy.stream".extraConfig = ''
        reverse_proxy 127.0.0.1:8096
      '';
      "files.server01.tuxy.stream".extraConfig = ''
        reverse_proxy 127.0.0.1:3923
      '';
    };

  };
}
