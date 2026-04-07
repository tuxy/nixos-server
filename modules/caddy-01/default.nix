{
  pkgs,
  config,
  ...
}: {
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
      hash = "sha256-FY33mTq6OExnbii0o9L/nELXplBxdE8AAYE9/EMmVsQ=";
    };
    configFile = ./caddy_config;
    environmentFile = config.age.secrets.cloudflare.path;
  };
}
