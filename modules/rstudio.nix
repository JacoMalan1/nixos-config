{ inputs, system, ... }:
let
  pkgs-stable = import inputs.nixpkgs-stable { inherit system; };
  rstudio-override = pkgs-stable.rstudioWrapper.override {
    packages = with pkgs-stable.rPackages; [
      ggplot2
      dplyr
      tidyverse
      maps
      rnaturalearth
      rnaturalearthdata
      gganimate
      sf
      gifski
      caret
      car
      mlbench
      pROC
      clValid
      cluster
      tm
      word2vec
      syuzhet
      SnowballC
      topicmodels
      textstem
    ];
  };
in { environment.systemPackages = [ rstudio-override ]; }
