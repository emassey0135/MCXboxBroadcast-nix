{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem(system:
      let pkgs = import nixpkgs {
        inherit system;
      };
        mcxboxbroadcast = (with pkgs;
          stdenv.mkDerivation {
            pname = "mcxboxbroadcast";
            version = "1.0";
            src = fetchurl {
              url = "https://github.com/MCXboxBroadcast/Broadcaster/releases/download/73/MCXboxBroadcastStandalone.jar";
              hash = "sha256-YB3heS+xTRshSBzIfCngtIXvZnDlz7l3vmmgqBkYqDU=";
            };
            phases = ["installPhase"];
            installPhase = ''
              mkdir -p $out/bin
              cp $src $out/bin/MCXboxBroadcastStandalone.jar
            '';
          }
        );
      in rec {
        defaultApp = flake-utils.lib.mkApp {
          drv = defaultPackage;
        };
        defaultPackage = mcxboxbroadcast;
      }
    );
}
