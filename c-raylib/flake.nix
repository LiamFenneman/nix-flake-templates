{
  description = "Liam's C+Raylib template";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      raylib-overlay = final: prev: {
        raylib = prev.raylib.overrideAttrs (old: {
          cmakeFlags = (old.cmakeFlags or [ ]) ++ [
            "-DUSE_WAYLAND=ON"
          ];
        });
      };
      pkgs = import nixpkgs { inherit system; overlays = [ raylib-overlay ]; };
    in
    {
      defaultPackage.${system} =
        with import nixpkgs { inherit system; };
        clangStdenv.mkDerivation {
          name = "c-raylib-template";
          src = self;
          buildInputs = with pkgs; [ raylib ];
          buildPhase = "clang -Wall -O3 -lraylib -o main ./main.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin main";
        };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          raylib
        ];
      };
    };
}
