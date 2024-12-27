{ inputs, system, ... }:
let
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit system; };
  rstudio-override = pkgs-unstable.rstudioWrapper.override { 
    packages = with pkgs-unstable.rPackages; [ 
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
in
{
  environment.systemPackages = [rstudio-override];
}
