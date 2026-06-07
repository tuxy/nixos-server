{
  pkgs,
  config,
  ...
}:
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
      hash = "sha256-HxqTeEVQLID3dwvcBqgkbHupqh4/3n8MD0UXsiPYJ78=";
    };
    configFile = ./caddy_config;
    environmentFile = config.age.secrets.cloudflare.path;
  };
}
