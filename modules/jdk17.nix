{ inputs, system, ... }:
let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  environment.systemPackages = with pkgs; [ jdk21 ];
  environment.sessionVariables = { JAVA_HOME = "${pkgs.jdk21}/lib/openjdk"; };
}
