{ lib, ... }: {
  options.flake.diskoConfigurations = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };

  options.flake.services = lib.mkOption {
    type = lib.types.attrsOf (lib.types.listOf (lib.types.submodule {
      options = {
        name = lib.mkOption {
          type = lib.types.str;
        };
        domain = lib.mkOption {
          type = lib.types.str;
        };
        port = lib.mkOption {
          type = lib.types.port;
        };
      };
    }));
    default = { };
  };

  options.flake.domains = lib.mkOption {
    type = lib.types.attrsOf lib.types.str;
    default = { };
  };

  options.flake.ports = lib.mkOption {
    type = lib.types.attrsOf lib.types.port;
    default = { };
  };

  config.systems = [ "x86_64-linux" ];
}