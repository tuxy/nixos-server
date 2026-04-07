{pkgs, ...}: {
  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = false;
    mediaLocation = "/data/media/immich";
    machine-learning.enable = true;
  };

  services.immich-public-proxy = {
    enable = true;
    immichUrl = "https://immich.server01.tuxy.party";
  };

  users.users."immich".extraGroups = ["media" "video" "render"];

  environment.systemPackages = with pkgs; [
    immich-go
  ];
}
