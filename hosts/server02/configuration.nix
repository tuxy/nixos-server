{
  modulesPath,
  pkgs,
  config,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/nextcloud
    ../../modules/nginx
    ../../modules/homepage
    ../../modules/telemetry
    ./disko-config.nix
  ];

  telemetry = {
    enableGrafana = true;
    host = "server02.tuxy.party";
  };

  age = {
    identityPaths = [ "/root/.ssh/id_rsa" ];
    secrets = {
      nextcloud-password = {
        file = ../../secrets/nextcloud-password.age;
        mode = "444";
        owner = config.users.users.nextcloud.name;
        group = config.users.users.nextcloud.group;
      };
      password.file = ../../secrets/password.age;
      tailscale-env.file = ../../secrets/tailscale-env.age;
    };
  };

  system.activationScripts."passwords" = ''
    export SECRET=$(cat ${config.age.secrets.password.path})
    export NEXTCLOUD_SECRET=$(cat "${config.age.secrets.nextcloud-password.path}")
    configFile=/etc/homepage-dashboard/services.yaml
    ${pkgs.gnused}/bin/sed -i "s#proxy_password#$SECRET#" "$configFile"
    ${pkgs.gnused}/bin/sed -i "s#grafana_password#$SECRET#" "$configFile"
    ${pkgs.gnused}/bin/sed -i "s#nextcloud_password#$NEXTCLOUD_SECRET#" "$configFile"
  '';

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

  networking.hostName = "server02";
  system.stateVersion = "25.11";
}
