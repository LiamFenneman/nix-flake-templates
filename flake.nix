{
  description = "Liam's flake templates";

  outputs = { self, ... }: {
    templates = {
      latex = {
        path = ./latex;
        description = "Blank LaTeX project";
      };
      latex-ieee = {
        path = ./latex-ieee;
        description = "LaTeX project with the IEEEtran style";
      };
      latex-vuw = {
        path = ./latex-vuw;
        description = "LaTeX project with the VUW handbook style";
      };
      rust = {
        path = ./rust;
        description = "Simple Hello World in Rust";
      };
      c = {
        path = ./c;
        description = "Simple Hello World in C";
      };
      c-raylib = {
        path = ./c-raylib;
        description = "Simple C project with raylib";
      };
    };
  };
}
