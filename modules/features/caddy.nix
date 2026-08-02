{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.caddy =
    {
      pkgs,
      config,
      lib,
      self,
      ...
    }:
    with lib;
    let
      cfg = config.caddy;
      hostName = config.networking.hostName;
      baseDomain = "${hostName}.${self.domains.base}";
    in
    {
      options.caddy = {
        enable = mkEnableOption "Caddy reverse proxy";

        package = mkOption {
          type = types.package;
          default = pkgs.caddy;
          defaultText = literalExpression "pkgs.caddy";
          description = ''
            Caddy package to use. Override with
            `pkgs.caddy.withPlugins` to add DNS-01 ACME
            challenge plugins such as cloudflare.
          '';
        };

        environmentFile = mkOption {
          type = types.nullOr types.path;
          default = null;
          description = ''
            Environment file loaded by the Caddy systemd service.
            Used to provide the `CF_API_TOKEN` for the Cloudflare
            DNS plugin, or other per-plugin environment variables.
          '';
        };

        proxies = mkOption {
          type = types.listOf (
            types.submodule {
              options = {
                subdomain = mkOption {
                  type = types.str;
                };
                port = mkOption {
                  type = types.port;
                };
                extraConfig = mkOption {
                  type = types.str;
                  default = "";
                };
              };
            }
          );
          default = [ ];
        };
      };

      config = mkIf cfg.enable {
        services.caddy = {
          enable = true;
          package = cfg.package;
          environmentFile = cfg.environmentFile;
          virtualHosts = listToAttrs (
            map (proxy: {
              name = "${proxy.subdomain}.${baseDomain}";
              value = {
                serverAliases = [ "${proxy.subdomain}.${baseDomain}" ];
                extraConfig = ''
                  reverse_proxy 127.0.0.1:${toString proxy.port}
                  ${proxy.extraConfig}
                '';
              };
            }) cfg.proxies
          );
        };
      };
    };
}
