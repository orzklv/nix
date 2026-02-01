{
  lib,
  pkgs,
  ...
}:
let
  inherit (pkgs) stdenv;

  home = if stdenv.hostPlatform.isDarwin then "Users" else "home";

  cfg = {
    # This is required information for home-manager to do its job
    home = {
      stateVersion = "25.11";
      username = "sakhib";
      homeDirectory = "/${home}/sakhib";
      enableNixpkgsReleaseCheck = false;
    };

    # Let's enable home-manager
    programs.home-manager.enable = true;
  };
in
{
  config = lib.mkMerge [
    cfg
  ];
}
