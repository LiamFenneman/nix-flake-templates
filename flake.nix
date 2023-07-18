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
      dev-shell = {
          path = ./dev-shell;
          description = "Empty Nix flake with a dev shell setup";
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
      html-serve = {
        path = ./html-serve;
        description = "Basic HTML server";
      };
      ruby = {
        path = ./ruby;
        description = "Simple Hello World in Ruby";
      };
    };
  };
}
