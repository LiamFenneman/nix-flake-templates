{
  description = "Liam's flake templates";

  outputs = { self, ... }: {
    templates = {
      latex = {
        path = ./latex;
        description = "A blank LaTeX project";
      };
      latex-ieee = {
        path = ./latex-ieee;
        description = "A LaTeX project with the IEEEtran style";
      };
      latex-vuw = {
        path = ./latex-vuw;
        description = "A LaTeX project with the VUW handbook style";
      };
      rust = {
        path = ./rust;
        description = "Simple Hello World in Rust";
      };
    };
  };
}
