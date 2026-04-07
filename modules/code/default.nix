{pkgs, ...}: {
  services.openvscode-server = {
    enable = true;
    host = "127.0.0.1";
    port = 4444;
    withoutConnectionToken = true;
    extraPackages = with pkgs; [
      gcc15
      rust-analyzer
      cargo
      ccls
      clang
      libclang
      llvmPackages.libc-full
    ];
  };
}
