{ ... }: {
  services.ntfy-sh = {
    enable = true;
    settings = {
      listen-http = "127.0.0.1:8182";
      base-url = "https://ntfy.server01.tuxy.party";
    };
  };
}
