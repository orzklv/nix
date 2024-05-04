{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding.x = 10;
        padding.y = 10;
        decorations = "buttonless";
      };

      font = {
        size = 12.0;
        use_thin_strokes = true;

        normal.family = "JetBrainsMono NF";
        bold.family = "JetBrainsMono NF";
        italic.family = "JetBrainsMono NF";
      };

      cursor.style = "Beam";

      shell = {
        program = "zsh";
        args = [
          "-C"
          "neofetch"
        ];
      };

      colors = {
        # Default colors
        primary = {
          background = "0x090909";
          foreground = "0xeceef0";
        };

        # Normal colors
        normal = {
          black = "0x546d79";
          red = "0xfe5151";
          green = "0x69efad";
          yellow = "0xffd640";
          blue = "0x40c3fe";
          magenta = "0xfe3f80";
          cyan = "0x64fcda";
          white = "0xfffefe";
        };

        # Bright colors
        bright = {
          black = "0xb0bdc4";
          red = "0xfe897f";
          green = "0xb9f5c9";
          yellow = "0xffe47e";
          blue = "0x80d7fe";
          magenta = "0xfe7faa";
          cyan = "0xa7fdeb";
          white = "0xfffefe";
        };
      };
    };
  };
}
