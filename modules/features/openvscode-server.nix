{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.openvscode-server =
    {
      pkgs,
      config,
      self,
      ...
    }:
    {
      services.openvscode-server = {
        enable = true;
        host = "127.0.0.1";
        port = self.ports.openvscode-server;
        extraArguments = [
          "--connection-token-file"
          config.age.secrets.vscode-token.path
        ];
        extraPackages = with pkgs; [
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
      };
    };
}
