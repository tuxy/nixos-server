{
  rustPlatform,
  fetchFromGitHub,
  lib,
}:

rustPlatform.buildRustPackage {
  pname = "jav-parser";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "tuxy";
    repo = "jav-parser";
    rev = "f68e6ba2ff5fabcfbd581af99586145212a3c25d";
    hash = "sha256-xQUhnFSL+pLntfuY7eKprmQkIz2OMwFU8j8A9ia8tf4=";
  };

  cargoHash = "sha256-Mt3A3eGOW+5dw9auqiz4KB64yW5zXMHbd/5xk/hi2H4=";

  meta = {
    description = "Parses JAV files and symlinks into destination";
    homepage = "https://github.com/tuxy/jav-parser";
    license = lib.licenses.mit;
  };
}
