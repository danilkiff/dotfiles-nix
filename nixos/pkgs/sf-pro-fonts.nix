{ stdenvNoCC, fetchFromGitHub, lib }:

stdenvNoCC.mkDerivation {
  pname = "sf-pro-fonts";
  version = "git-2025-09-09";

  src = fetchFromGitHub {
    owner = "sahibjotsaggu";
    repo  = "San-Francisco-Pro-Fonts";
    rev   = "8bfea09aa6f1139479f80358b2e1e5c6dc991a58";
    sha256 = "0zm9112y5x6z36mhcqlga4lmiqjhp1n7qiszmd3h3wi77z3c81cq"; # nix-prefetch-url --unpack https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip
  };

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    find . -type f -iname '*.otf' -exec cp -v '{}' $out/share/fonts/opentype/ \;

    mkdir -p $out/share/fonts/truetype
    find . -type f -iname '*.ttf' -exec cp -v '{}' $out/share/fonts/truetype/ \;
  '';

  meta = with lib; {
    description = "Apple San Francisco Pro (unofficial packaging)";
    license = licenses.unfreeRedistributable;
    platforms = platforms.linux;
  };
}
