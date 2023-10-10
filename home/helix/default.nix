{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "autumn_night";

      editor = {
        line-number = "relative";

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };


        file-picker = {
          hidden = false;
        };

        statusline = {
          left = [ "mode" "spinner" ];

          center = [ "file-name" ];

          right = [
            "diagnostics"
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];

          separator = "│";

          mode = {
            normal = "SLAVE";
            insert = "MASTER";
            select = "DUNGEON";
          };
        };

      };

      keys.normal = {
        # Easy window movement
        "C-left" = "jump_view_left";
        "C-right" = "jump_view_right";
        "C-up" = "jump_view_up";
        "C-down" = "jump_view_down";

        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";

        "C-r" = ":reload";
      };
    };
  };
}