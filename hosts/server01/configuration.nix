{
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/copyparty
    ../../modules/caddy-01
    ../../modules/syncthing
    ../../modules/telemetry
    ../../modules/immich
    ../../modules/cloudflare
    ../../modules/backup
    ../../modules/ntfy
    ./disko-config.nix
    ./media.nix
  ];

  telemetry.enableGrafana = false;

  age = {
    identityPaths = [ "/root/.ssh/id_rsa" ];
    secrets = {
      wgconf.file = ../../secrets/wg.conf.age;
      wgproxyconf.file = ../../secrets/wgproxy.conf.age;
      password.file = ../../secrets/password.age;
      tailscale-env.file = ../../secrets/tailscale-env.age;
      cloudflare.file = ../../secrets/cloudflare.age;
      immich-proxy.file = ../../secrets/immich-proxy.age;
      restic-server01.file = ../../secrets/restic-server01.age;
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-compute-runtime
    ];
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    gitMinimal
    rsync
    screen
    tmux
    wget
    neovim
    htop
    compsize
  ];

  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDLfc3ejrJs5DVz75LIbOMe+HgUQuKdwWDRWL412q60TO7OW7G7seip0ubdwUKfMuB6VryVn8JcI/y7bfjhMKcgR4RqP3ryVlXN6bQQNyaZWyKAtRBz6Wx2P0xmlB7H2QGTSIbGTs3DRZ6HJ7u0YKbX66PTc4kKyfqFesBq7lmcl7LGRhuF2GIawjLn7BOJJwFYB/rjDTUErDkrMPlcIX2iXVw7RO/YGwfS+5V7YYk7gLsrBfG7QPSyMGRpXkGCOU7ZVcqBq6SH+mtUdjwEx657dYgKq4vu1fE01Qid6W5vvSIcnlOGUWQjxsHR0IlpVnY25aZgsVzrTpFV0uQQz3KGlFDoGmBIB7jrt6EqR5FNQ9R3X76J72Q5eIN2vzyOV54vMrGWf5xsAK5mTEmkeS/W9c71Weyda/8NbM/aEDvCkkEXRmx6iM4jh6A6ZrXz1Jv+Cnnc3xLKAG24ZyAYBSIV8sEQiDWxJVEvhhmDlZvD2pHitfZdC9oVN+9jUFQ3Zek= tuxy@deskputer"
    ];
    initialHashedPassword = "$y$j9T$jgdWoMIYyBf6tKZnrK9hC/$WsIHH4TErqaC8MLJnKm8Lh3aOkjvAOUluzybnkQIi86";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "server01";
  system.stateVersion = "25.11";
}
