{
  self,
  inputs,
  ...
}:
let
  inherit (builtins) map listToAttrs;
  server01 = [
    { name = "copyparty"; domain = "files"; port = 8080; }
    { name = "immich"; domain = "immich"; port = 8081; }
    { name = "syncthing"; domain = "sync"; port = 8082; }
    { name = "radicale"; domain = "cal"; port = 8083; }
    { name = "ntfy"; domain = "ntfy"; port = 8084; }
  ];
  server02 = [
    { name = "hydra"; domain = "hydra"; port = 8080; }
    { name = "beszel"; domain = "beszel"; port = 8081; }
    { name = "gachix"; domain = "cache"; port = 8082; }
    { name = "openvscode-server"; domain = "code"; port = 8083; }
  ];
  allServices = server01 ++ server02;
in
{
  config.flake.services = {
    inherit server01 server02;
  };

  config.flake.domains = (listToAttrs (map (s: { name = s.name; value = s.domain; }) allServices)) // {
    base = "tuxy.party";
  };

  config.flake.ports = listToAttrs (map (s: { name = s.name; value = s.port; }) allServices);
}