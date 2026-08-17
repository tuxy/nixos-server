{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.server02Configuration =
    {
      pkgs,
      config,
      self,
      ...
    }:
    {
      imports = [
        self.diskoConfigurations.server02
        self.nixosModules.zfs
        self.nixosModules.beszel
        self.nixosModules.ci
        self.nixosModules.caddy
        self.nixosModules.openvscode-server
        self.nixosModules.tailscale
      ];

      networking.hostName = "server02";

      age.rekey = {
        hostPubkey = builtins.readFile ../../../secrets/pubkeys/server02.pub;
        masterIdentities = [ "/home/tuxy/.ssh/id_rsa" ];
        storageMode = "local";
        localStorageDir = ../../../secrets/rekeyed/server02;
      };

      age.secrets = {
        tailscale = {
          rekeyFile = ../../../secrets/tailscale.age;
        };
        vscode-token = {
          rekeyFile = ../../../secrets/vscode-token.age;
        };
        cloudflare-dns = {
          rekeyFile = ../../../secrets/cloudflare-dns.age;
        };
      };

      caddy = {
        enable = true;
        package = pkgs.caddy.withPlugins {
          plugins = [
            "github.com/caddy-dns/cloudflare@v0.2.2"
          ];
          hash = "sha256-HxqTeEVQLID3dwvcBqgkbHupqh4/3n8MD0UXsiPYJ78=";
        };
        environmentFile = config.age.secrets.cloudflare-dns.path;
        proxies = map (svc: {
          subdomain = svc.domain;
          port = svc.port;
        }) self.services.server02;
      };

      zfs = {
        poolName = "tank";
        drives = [
          "/dev/disk/by-id/ata-disk-1"
          "/dev/disk/by-id/ata-disk-2"
          "/dev/disk/by-id/ata-disk-3"
          "/dev/disk/by-id/ata-disk-4"
          "/dev/disk/by-id/ata-disk-5"
        ];
        datasets = {
          server01 = {
            mountPoint = "/export/server01";
            nfsExport = "sec=sys,rw,no_subtree_check,async";
          };
          server02 = {
            mountPoint = "/export/server02";
          };
        };
        symlinks."/data" = "/export/server02";
      };

      boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      services.openssh.enable = true;

      users.users.root.openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnJtXNZxPonY6RnxdwroXfH5MTthui+x2hfGtzHrb7DCOyo53wriHMbPGf8E9cWGgQn1hGlqKJeZJAG+ifNLhgSEM+H7CiG3W2RrFaI4n4DOmJUWa1um5LM95LWQP7oGugHJlTHYvXCW+SaVdK1B4jqjWRrDWA19Elhcz/YFJDeRuX4uFARIzxh5CWqT89YrhhRE2S0O4nKHTSL7IbGG8WWq0RKHg9UhoJA6bfuufvAquUrJaWOTDJPAT7a4mzbSd93ItWAKZT5BTCsIscJ7FsOPbF82EfNAcj6ORYMYELENhnUtJCW1QpGW5g5AE7erovo2wB0yGQ86KwYJ7e/UXunm8w7Ku6N4SNsoFS+hbB69DNH+tRy3XVmVhtmZKDvzwtQPg/5WmTLojx2kpnSHt0MQTRhlJSTvv5uFSWdGOxsqIXDzvp7TBbgM6nagYdeYj9/VMG0gw7nhWjhe2y4u/kY/hf4SQsKUU3c6twLIfLHmQae+nXlaViRVootNTxXk0="
      ];

      system.stateVersion = "26.05";
    };
}
