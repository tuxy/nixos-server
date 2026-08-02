{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.syncthing =
    { pkgs, config, self, ... }:
    {
      services.syncthing = {
        enable = true;
        dataDir = "/data/syncthing";
        configDir = "/data/.state/syncthing";
        guiAddress = "127.0.0.1:${toString self.ports.syncthing}";
        overrideFolders = true;
        overrideDevices = true;
      };
    };
}