{ inputs, system, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  rstudio-override = pkgs-stable.rstudioWrapper.override {
    packages = with pkgs-stable.rPackages; [
      ggplot2
      dplyr
      tidyverse
      sf
      caret
    ];
  };
in { environment.systemPackages = [ rstudio-override ]; }
