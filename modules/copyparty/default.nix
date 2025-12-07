{ pkgs, config, ... }:
{
  environment.systemPackages = [ pkgs.copyparty ];
  services.copyparty = {
    enable = true;
    user = "root";
    group = "media";

    settings = {
      i = "127.0.0.1";
    };

    accounts.tuxy.passwordFile = config.age.secrets.password.path;

    volumes."/" = {
      path = "/data";
      access.rw = [ "tuxy" ];
    };
  };
}
