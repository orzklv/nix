{pkgs, ...}: {
  imports = [
    ./gpg-agent.nix
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;

    # User credentials
    userName = "Sokhibjon Orzikulov";
    userEmail = "sakhib@orzklv.uz";

    extraConfig = {
      http.sslVerify = false;
    };

    # GPG Signing
    signing = {
      signByDefault = true;
      key = "00D27BC687070683FBB9137C3C35D3AF0DA1D6A8";
    };

    # Aliases
    aliases = {
      ch = "checkout";
    };

    # Git ignores
    ignores = [
      ".idea"
      ".DS_Store"
    ];
  };
}
