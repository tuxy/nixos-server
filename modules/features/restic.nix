{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.restic =
    { pkgs, config, self, ... }:
    {
      services.restic.backups = {
        weekly = {
          user = "root";
          paths = [ "/data" ];
          repository = "b2:my-bucket:server01";
          environmentFile = config.age.secrets.restic-env.path;
          timerConfig = {
            OnCalendar = "weekly";
            Persistent = true;
          };
          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 4"
            "--keep-monthly 3"
          ];
        };
      };
    };
}