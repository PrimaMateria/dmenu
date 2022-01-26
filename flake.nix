{
  description = "PrimaMateria dmenu flake";
  inputs.nixpkgs.url = "nixpkgs/nixos-21.11";
  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.dmenu-primamateria = 
      with import nixpkgs { system = "x86_64-linux"; };
      stdenv.mkDerivation rec {
        name = "dmenu-primamateria";
        src = self;
        buildInputs = [ xorg.libX11 xorg.libXinerama zlib xorg.libXft ];
        postPatch = ''
          sed -ri -e 's!\<(dmenu|dmenu_path|stest)\>!'"$out/bin"'/&!g' dmenu_run
          sed -ri -e 's!\<stest\>!'"$out/bin"'/&!g' dmenu_path
        '';
        preConfigure = ''
          sed -i "s@PREFIX = /usr/local@PREFIX = $out@g" config.mk
        '';
        makeFlags = [ "CC:=$(CC)" ];
      };
  };
}
