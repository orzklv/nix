{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Package sets for different targets
  macos = import ./osx.nix { inherit pkgs; };
  linux = import ./linux.nix { inherit pkgs; };
  globals = import ./global.nix { inherit pkgs; };
in
{
  config = {
    # Packages to be installed on my machine
    home.packages = if pkgs.stdenv.hostPlatform.isDarwin then globals ++ macos else globals ++ linux;
  };
}
