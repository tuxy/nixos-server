{ pkgs, config, ... }:
{
  users.groups.nextcloud = { };
  users.users.nextcloud = {
    isSystemUser = true;
    group = "nextcloud";
  };

  services.nginx = {
    defaultHTTPListenPort = 8111;
    defaultListenAddresses = [ "127.0.0.1" ];
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    configureRedis = true;
    database.createLocally = true;
    hostName = "server02.tuxy.party";
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        news
        contacts
        calendar
        tasks
        ;
    };
    extraAppsEnable = true;
    config = {
      adminuser = "tuxy";
      adminpassFile = config.age.secrets.nextcloud-password.path;
      dbtype = "sqlite";
    };
    settings = {
      trusted_domains = [ "cloud.server02.tuxy.party" ];
      trusted_proxies = [ "127.0.0.1" ];
    };
  };
}
