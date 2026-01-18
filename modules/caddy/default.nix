{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nss
    nssTools
  ];
  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.2"
        "github.com/caddy-dns/acmedns@v0.6.0"
      ];
      hash = "sha256-WulWr4lUJ7hTRXaLPCGI11p7tsH5YKu5epkhR86Mhgc=";
    };
    configFile = ./caddy_config;
  };
}
