{
  stdenv,
  lib,
  fetchzip,
}:

stdenv.mkDerivation rec {
  pname = "metatube-server";
  version = "1.3.1";

  # 1. Fetch the binary release archive
  src = fetchzip {
    url = "https://github.com/metatube-community/metatube-server-releases/releases/download/v${version}/metatube-server-linux-amd64-v3.zip";
    hash = "sha256-UgpGsSfEJZinaj/8pPTAmgb2ugAunXieZLVVfK3adfA=";
  };

  installPhase = ''
    ls -la
    # Assuming the tarball contains a single executable called 'myservice-bin'
    mkdir -p $out/bin
    # Copy the executable into the $out/bin directory
    cp metatube-server-linux-amd64-v3 $out/bin/metatube-server

    # Ensure it's executable
    chmod +x $out/bin/metatube-server
  '';

  meta = with lib; {
    description = "metatube-server for metadata";
    homepage = "https://github.com/metatube-community";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
