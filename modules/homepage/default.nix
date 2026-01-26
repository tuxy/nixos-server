{ ... }:
{
  imports = [
    ./services.nix
    ./widgets.nix
    ./settings.nix
    ./bookmarks.nix
  ];

  services.homepage-dashboard = {
    enable = true;
    allowedHosts = "home.tuxy.party";
  };
}
