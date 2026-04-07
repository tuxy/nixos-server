{...}: {
  services.collabora-online = {
    enable = true;
    port = 9980;
    settings = {
      ssl = {
        enable = false;
        termination = true;
      };

      net = {
        listen = "loopback";
        post_allow.host = ["::1"];
      };

      storage.wopi = {
        "@allow" = true;
        host = ["cloud.tuxy.party"];
      };

      # Set FQDN of server
      server_name = "collabora.tuxy.party";
    };
  };
}
