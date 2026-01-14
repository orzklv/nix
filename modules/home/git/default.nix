{
  config,
  pkgs,
  lib,
  ...
}:
{
  options = {
    git = {
      isMacOS = lib.mkOption {
        type = lib.types.bool;
        default = pkgs.stdenv.hostPlatform.isDarwin;
        description = "Install MacOS specific agent.";
      };
    };
  };

  config = {
    # Git Configurations
    programs.git = {
      enable = true;
      lfs.enable = true;

      settings = {
        # User credentials
        user.email = "sakhib@orzklv.uz";
        user.name = "Sokhibjon Orzikulov";

        # Aliases
        aliases = {
          ch = "checkout";
        };

        # Spicy configs
        extraConfig = {
          http.sslVerify = false;
          pull.rebase = true;
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
      if config.git.isMacOS then
        ''
          pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
        ''
      else
        '''';

    home.file.".gnupg/gpg.conf".text =
      if config.git.isMacOS then
        ''
          no-tty
          use-agent
        ''
      else
        '''';
  };
}
