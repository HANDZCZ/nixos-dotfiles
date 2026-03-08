{ osConfig, config, ... }:

{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd = {
            enable = true;
            settings =
              let
                flake = ''(builtins.getFlake "${config.xdg.configHome}/nixos")'';
              in {
                nixpkgs.expr = "import ${flake}.inputs.nixpkgs {}";
                options = {
                  nixos.expr = "${flake}.nixosConfigurations.${osConfig.system.name}.options";
                  home-manager.expr = ''
                    let
                      flake = ${flake};
                      pkgs = import flake.inputs.nixpkgs {};
                    in (flake.inputs.home-manager.lib.homeManagerConfiguration {
                      inherit pkgs;
                      modules = with flake.inputs; [
                        nixvim.homeModules.nixvim
                        nixcord.homeModules.nixcord
                        noctalia.homeModules.default
                        {
                          home = {
                            username = "bogus";
                            homeDirectory = "/tmp/bogus";
                            stateVersion = "${config.home.stateVersion}";
                          };
                        }
                      ];
                    }).options
                  '';
                };
              };
          };
        };
        luaConfig.post = ''
          vim.api.nvim_set_hl(0, "DiagnosticDeprecated", { strikethrough = false })
        '';
      };
    };
  };
}

