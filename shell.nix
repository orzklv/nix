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
}:
pkgs.stdenv.mkDerivation {
  name = "nix";

  nativeBuildInputs = with pkgs; let
    linter = statix.overrideAttrs {
      version = "dev";
      src = fetchFromGitHub {
        owner = "oppiliappan";
        repo = "statix";
        rev = "e9df54ce918457f151d2e71993edeca1a7af0132";
        sha256 = "sha256-duH6Il124g+CdYX+HCqOGnpJxyxOCgWYcrcK0CBnA2M=";
      };
      cargoHash = "sha256-IeVGsrTXqmXbKRbJlBDv02fJ+rPRjwuF354/jZKRK/M=";
    };
  in [
    git
    just
    nixd
    sops
    linter

    deadnix
    alejandra
  ];

  shellHook = ''
    # Fetch whatever update
    git pull
  '';

  NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";
}
