{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
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
              url = "https://github.com/MCXboxBroadcast/Broadcaster/releases/download/85/MCXboxBroadcastStandalone.jar";
              hash = "sha256-7lswxv6E29Zox1QoZ9LfXck7JxsjrJAIze1pZX6vGz4=";
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
