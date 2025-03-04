{...}: {
  config = {
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "orzklv";
          padding = {
            top = 3;
            right = 3;
            left = 3;
          };
        };
        display = {
          size = {binaryPrefix = "si";};
          color = "black";
        };
        modules = [
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "de"
          "wm"
          "wmtheme"
          "theme"
          "icons"
          "font"
          "cursor"
          "terminal"
          "terminalfont"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          "localip"
          "battery"
          "poweradapter"
          "locale"
          "break"
          "colors"
        ];
      };
    };
  };
}
