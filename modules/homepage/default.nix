{ ... }:
{
  imports = [
    ./services.nix
    ./widgets.nix
    ./settings.nix
  ];

  services.homepage-dashboard = {
    enable = true;
    allowedHosts = "home.server02.tuxy.party";
  };
}
