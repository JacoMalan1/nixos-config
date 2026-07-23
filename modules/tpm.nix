{ inputs, system, ... }: 
let
  pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  environment.systemPackages = with pkgs; [ tpm2-tools ];

  users.users.jacom.extraGroups = [ "tss" ];
}
