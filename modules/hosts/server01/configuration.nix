{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.server01Configuration =
    {
      pkgs,
      config,
      self,
      ...
    }:
    {
      imports = [
        self.nixosModules.nfs-client
        self.nixosModules.caddy
        self.nixosModules.radicale
        self.nixosModules.syncthing
        self.nixosModules.ntfy
        self.nixosModules.restic
        self.nixosModules.immich
        self.nixosModules.beszel-agent
        self.nixosModules.user
      ];

      networking.hostName = "server01";

      age.secrets = {
        radicale-passwd = {
          rekeyFile = ../../../secrets/radicale-passwd.age;
        };
        restic-env = {
          rekeyFile = ../../../secrets/restic-env.age;
        };
        cloudflared-credentials = {
          rekeyFile = ../../../secrets/cloudflared-credentials.age;
        };
        beszel-agent-env = {
          rekeyFile = ../../../secrets/beszel-agent-env.age;
        };
        cloudflare = {
          rekeyFile = ../../../secrets/cloudflare.age;
        };
      };

      age.rekey = {
        hostPubkey = builtins.readFile ../../../secrets/pubkeys/server01.pub;
        masterIdentities = [ "/home/tuxy/.ssh/id_rsa" ];
        storageMode = "local";
        localStorageDir = ../../../secrets/rekeyed/server01;
      };

      caddy = {
        enable = true;
        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/cloudflare@v0.2.2"
          ];
          hash = "sha256-HxqTeEVQLID3dwvcBqgkbHupqh4/3n8MD0UXsiPYJ78=";
        };
        environmentFile = config.age.secrets.cloudflare.path;
        proxies = map (svc: { subdomain = svc.domain; port = svc.port; }) self.services.server01;
      };

      immich = {
        enable = true;
        publicProxy = {
          enable = true;
        };
        cloudflareTunnel = {
          enable = true;
          tunnelId = "00000000-0000-0000-0000-000000000000";
          domain = "photos.${config.networking.hostName}.${self.domains.base}";
        };
      };

      nfs.mounts.data = {
        server = "server02.lan";
        export = "/export/server01";
        mountPoint = "/data";
      };

      user.root.authorizedKeys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnJtXNZxPonY6RnxdwroXfH5MTthui+x2hfGtzHrb7DCOyo53wriHMbPGf8E9cWGgQn1hGlqKJeZJAG+ifNLhgSEM+H7CiG3W2RrFaI4n4DOmJUWa1um5LM95LWQP7oGugHJlTHYvXCW+SaVdK1B4jqjWRrDWA19Elhcz/YFJDeRuX4uFARIzxh5CWqT89YrhhRE2S0O4nKHTSL7IbGG8WWq0RKHg9UhoJA6bfuufvAquUrJaWOTDJPAT7a4mzbSd93ItWAKZT5BTCsIscJ7FsOPbF82EfNAcj6ORYMYELENhnUtJCW1QpGW5g5AE7erovo2wB0yGQ86KwYJ7e/UXunm8w7Ku6N4SNsoFS+hbB69DNH+tRy3XVmVhtmZKDvzwtQPg/5WmTLojx2kpnSHt0MQTRhlJSTvv5uFSWdGOxsqIXDzvp7TBbgM6nagYdeYj9/VMG0gw7nhWjhe2y4u/kY/hf4SQsKUU3c6twLIfLHmQae+nXlaViRVootNTxXk0="
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      services.openssh.enable = true;

      system.stateVersion = "26.05";
    };
}
