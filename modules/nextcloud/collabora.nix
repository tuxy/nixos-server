{ ... }: {
    virtualisation.oci-containers.containers.collabora = {
      image = "docker.io/collabora/code";
      ports = [ "127.0.0.1:9980:9980" ];
      autoStart = true;
      environment = {
        aliasgroup1 = "https://cloud.tuxy.party";
        aliasgroup2 = "https://collabora.server02.tuxy.party";
        extra_params = "--o:ssl.enable=false --o:storage.wopi.host[nextcloud]=true --o:net.proto=IPv4";
      };
    };
}
