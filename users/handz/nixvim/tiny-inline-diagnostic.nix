{ ... }:

{
  programs.nixvim = {
    plugins = {
      tiny-inline-diagnostic = {
        enable = true;
        settings = {
          preset = "powerline";
          options = {
            show_source = {
              enabled = true;
            };
            multilines = {
              enabled = true;
            };
            add_messages = {
              messages = true;
              display_count = false;
            };
          };
          hi = {
            background = "none";
          };
        };
      };
    };
  };
}

