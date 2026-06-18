{
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = [
    pkgs.restic
    pkgs.borgbackup
  ];
  services.restic.backups = {
    server01 = {
      user = "root";
      environmentFile = config.age.secrets.restic-server01.path;
      paths = [
        "/data/media/immich"
        "/data/media/.state"
        "/data/media/.file-lists"
      ];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
      };
    };
  };
}
