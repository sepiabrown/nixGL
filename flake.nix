{
  description = ''NixGL solve the "OpenGL" problem with nix'';
  inputs = {
    flake-utils.url = "github:numtide/flake-utils/master";
    nixpkgs.url = "github:nixos/nixpkgs/haskell-updates";
  };
  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib;
    eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        };
        auto = (import ./. { inherit pkgs; }).auto;
      in rec {
        packages = flattenTree (pkgs.recurseIntoAttrs auto);
        defaultPackage = auto.nixGLDefault;
      });
}
