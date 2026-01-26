{
  config,
  lib,
  ...
}:
{

  options.telemetry.enableGrafana = lib.mkOption {
    type = lib.types.bool;
  };
  options.telemetry.host = lib.mkOption {
    type = lib.types.str;
    default = "";
  };

  config.services.grafana = {
    enable = config.telemetry.enableGrafana;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3003;
        domain = "graph.tuxy.party";
      };
    };
  };

  config.services.prometheus = {
    enable = true;
    port = 9001;
    scrapeConfigs = [
      {
        job_name = "local_scrape";
        static_configs = [
          {
            targets = [
              "127.0.0.1:${toString config.services.prometheus.exporters.systemd.port}"
              "127.0.0.1:${toString config.services.prometheus.exporters.node.port}"
            ];
          }
        ];
      }
    ];
    exporters = {
      tailscale = {
        enable = true;
        environmentFile = config.age.secrets.tailscale-env.path;
      };
      systemd.enable = true;
      nginx.enable = true;

      node = {
        enable = true;
        enabledCollectors = [
          "systemd"
        ];
        port = 9002;
      };

    };
  };
}
