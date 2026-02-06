{
  config,
  pkgs,
  lib,
  ...
}:
{
  config = {
    # Git Configurations
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        # User credentials
        user = {
          email = "sakhib@orzklv.uz";
          name = "Sokhibjon Orzikulov";
        };

        # Aliases
        aliases = {
          ch = "checkout";
        };

        # Alwayws pull rebase
        pull.rebase = true;

        # Spicy configs
        extraConfig = {
          http.sslVerify = false;
        };
      };

      # GPG Signing
      signing = {
        signByDefault = true;
        key = "00D27BC687070683FBB9137C3C35D3AF0DA1D6A8";
      };

      # Git ignores
      ignores = [
        ".idea"
        ".DS_Store"
        "nohup.out"
      ];
    };

    home.file.".gnupg/gpg-agent.conf".text =
      if pkgs.stdenv.hostPlatform.isDarwin then
        ''
          pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        ''
      else
        "";

    home.file.".gnupg/gpg.conf".text =
      if pkgs.stdenv.hostPlatform.isDarwin then
        ''
          no-tty
          use-agent
        ''
      else
        "";
  };
}
