# Use this as a playground to test nix expressions
# export NIXPKGS_ALLOW_UNFREE=1 && nix repl -f ./repl.nix --impure
{
  pkgs ? let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: let
  lib = pkgs.lib;

  non-aarch64 = [
    pkgs.discord
  ];

  all-packages =
    (with pkgs; [
      telegram-desktop
      discord
    ])
    ++ (with pkgs.unstable; []);

  packages =
    if pkgs.stdenv.hostPlatform.isAarch64
    then lib.filter (pkg: !lib.elem pkg non-aarch64) all-packages
    else all-packages;
in {
  inherit packages;
}
