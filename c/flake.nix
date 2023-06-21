{
  description = "Liam's C template";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage.${system} =
        with import nixpkgs { inherit system; };
        clangStdenv.mkDerivation {
          name = "c-template";
          src = self;
          buildInputs = with pkgs; [ ];
          buildPhase = "clang -Wall -O3 -o main ./main.c";
          installPhase = "mkdir -p $out/bin; install -t $out/bin main";
        };
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [ ];
      };
    };
}
