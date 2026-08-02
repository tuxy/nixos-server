{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.openvscode-server = {
    pkgs,
    lib,
    config,
    self,
    ...
  }: let
    cfg = config.tuxy.openvscode-server;
  in {
    options.tuxy.openvscode-server.extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        gcc15
        rust-analyzer
        cargo
        ccls
        clang
        gnumake
        libclang
        opencode
        llvmPackages.libc-full
      ];
      description = "Extra packages to add to the openvscode-server environment.";
    };

    config.services.openvscode-server = {
      enable = true;
      user = "tuxy";
      group = "users";
      host = "127.0.0.1";
      port = self.ports.openvscode-server;
      extraArguments = ["--connection-token-file" config.age.secrets.vscode-token.path];
      extraPackages = cfg.extraPackages;
    };
  };
}
