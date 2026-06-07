{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:
rustPlatform.buildRustPackage {
  pname = "jav-parser";
  version = "0.1.1";

  src = builtins.fetchGit {
    url = "git@github.com:tuxy/jav-parser.git";
    rev = "729bc0cbcee87557e5f76cc86d9cbcc304baae52";
  };

  cargoHash = "sha256-Mt3A3eGOW+5dw9auqiz4KB64yW5zXMHbd/5xk/hi2H4=";

  meta = {
    description = "Parses JAV files and symlinks into destination";
    homepage = "https://github.com/tuxy/jav-parser";
    license = lib.licenses.mit;
  };
}
