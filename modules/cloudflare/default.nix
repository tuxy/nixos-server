{
  pkgs,
  config,
  ...
}: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "f18432ba-750b-4edc-ad39-d510f3aa2663" = {
        credentialsFile = "${config.age.secrets.immich-proxy.path}";
        default = "http_status:404";
      };
    };
  };
}
