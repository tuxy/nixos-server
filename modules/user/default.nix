{ ... }:
{
  #users.users.tuxy = {
  #  createHome = true;
  #  extraGroups = [
  #    "wheel"
  #  ];
  #  group = "users";
  #  isNormalUser = true;
  #};

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnJtXNZxPonY6RnxdwroXfH5MTthui+x2hfGtzHrb7DCOyo53wriHMbPGf8E9cWGgQn1hGlqKJeZJAG+ifNLhgSEM+H7CiG3W2RrFaI4n4DOmJUWa1um5LM95LWQP7oGugHJlTHYvXCW+SaVdK1B4jqjWRrDWA19Elhcz/YFJDeRuX4uFARIzxh5CWqT89YrhhRE2S0O4nKHTSL7IbGG8WWq0RKHg9UhoJA6bfuufvAquUrJaWOTDJPAT7a4mzbSd93ItWAKZT5BTCsIscJ7FsOPbF82EfNAcj6ORYMYELENhnUtJCW1QpGW5g5AE7erovo2wB0yGQ86KwYJ7e/UXunm8w7Ku6N4SNsoFS+hbB69DNH+tRy3XVmVhtmZKDvzwtQPg/5WmTLojx2kpnSHt0MQTRhlJSTvv5uFSWdGOxsqIXDzvp7TBbgM6nagYdeYj9/VMG0gw7nhWjhe2y4u/kY/hf4SQsKUU3c6twLIfLHmQae+nXlaViRVootNTxXk0="
  ];
}
