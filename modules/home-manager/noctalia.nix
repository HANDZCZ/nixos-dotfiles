{ pkgs, lib, config, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  home.packages = with pkgs; [
    cliphist
    xdg-desktop-portal
  ] ++ lib.optionals config.programs.noctalia-shell.settings.appLauncher.useApp2Unit [ app2unit ];
}
