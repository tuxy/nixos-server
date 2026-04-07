{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:
rustPlatform.buildRustPackage {
  pname = "jav-parser";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "tuxy";
    repo = "jav-parser";
    rev = "729bc0cbcee87557e5f76cc86d9cbcc304baae52";
    hash = "sha256-kyFfvt4wDvj6j+/eQgeXkLV9+oR2lW4VC2E3OSfE0AE=";
  };

  cargoHash = "sha256-Mt3A3eGOW+5dw9auqiz4KB64yW5zXMHbd/5xk/hi2H4=";

  meta = {
    description = "Parses JAV files and symlinks into destination";
    homepage = "https://github.com/tuxy/jav-parser";
    license = lib.licenses.mit;
  };
}
