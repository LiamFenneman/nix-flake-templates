{
  description = "Liam's LaTeX template with IEEE conference style";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        documentName = "report"; # do not include ".tex"

        pkgs = import nixpkgs { inherit system; };

        tex = pkgs.texlive.combined.scheme-full;
        # tex = pkgs.texlive.combine {
        #   inherit (pkgs.texlive) scheme-minimal latexmk;
        # };
      in
      rec
      {
        packages.document = pkgs.stdenvNoCC.mkDerivation rec {
          name = "ieee-report";

          src = self;
          buildInputs = with pkgs; [ coreutils tex gzip perl ];
          phases = [ "unpackPhase" "buildPhase" "installPhase" ];

          buildPhase = ''
            export PATH="${pkgs.lib.makeBinPath buildInputs}";
            mkdir -p .cache/texmf-var
            env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
              SOURCE_DATE_EPOCH=${toString self.lastModified} \
              latexmk -interaction=nonstopmode -pdflatex \
              -pretex="\pdftrailerid{}" \
              -usepretex -synctex=1 ${documentName}.tex
          '';

          # use lualatex instead of pdflatex
          # buildPhase = ''
          #   export PATH="${pkgs.lib.makeBinPath buildInputs}";
          #   mkdir -p .cache/texmf-var
          #   env TEXMFHOME=.cache TEXMFVAR=.cache/texmf-var \
          #     SOURCE_DATE_EPOCH=${toString self.lastModified} \
          #     latexmk -interaction=nonstopmode -lualatex \
          #     -pretex="\pdfvariable suppressoptionalinfo 512\relax" \
          #     -usepretex -synctex=1 ${documentName}.tex
          # '';

          installPhase = ''
            mkdir -p $out
            gzip -d ${documentName}.synctex.gz
            perl -i -pe 's|^(Input:\d+:)/build/source(.*)$|\1..\2|g' ${documentName}.synctex
            gzip ${documentName}.synctex
            cp ${documentName}.pdf $out/
            cp ${documentName}.synctex.gz $out/
          '';
        };
        defaultPackage = packages.document;
      }
    );
}
