{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  environment.systemPackages = with pkgs; [ jdk17 ];
  environment.sessionVariables = { JAVA_HOME = "${pkgs.jdk17}/lib/openjdk"; };
}
