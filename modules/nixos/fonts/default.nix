{ pkgs, ... }: {
  config = {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      (nerdfonts.override {
        fonts = [ "JetBrainsMono" ];
      })
    ];
  };
}
