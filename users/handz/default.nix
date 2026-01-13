{ pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/niri.nix
    ../../modules/steam.nix
  ];

  users.users.handz = {
    isNormalUser = true;
    initialPassword = "secure_tm";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [];
  };

  programs = {
    # needed to open ports
    localsend.enable = true;
    gpu-screen-recorder.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.handz = import ./home.nix;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs;
    };
  };
  environment.sessionVariables = {
    XFT_DPI = "96";
  };
}
