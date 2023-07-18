{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        # Compile-time dependencies
        nativeBuildInputs = with pkgs; [ ];

        # Runtime dependencies
        buildInputs = with pkgs; [ ];
      in
      with pkgs;
      {
        devShells.default = mkShell {
          inherit nativeBuildInputs buildInputs;
        };
      }
    );
}
