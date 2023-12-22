{ config, pkgs, lib, ... }:

let
  macos = import ./osx.nix { inherit pkgs; };
  linux = import ./linux.nix { inherit pkgs; };
  globals = import ./globals.nix { inherit pkgs; };
in
{
  options = {
    packages = {
      isMacOS = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Is installed packages are MacOS targetted.";
      };
    };
  };

  config = {
    home.packages = 
      if config.packages.isMacOS then
        globals ++ macos
      else
        globals ++ linux;
  };
}