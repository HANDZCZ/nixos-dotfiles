{ ... }:

{
  programs.nixvim = {
    plugins = {
      tiny-inline-diagnostic = {
        enable = true;
        settings = {
          preset = "powerline";
          options = {
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

