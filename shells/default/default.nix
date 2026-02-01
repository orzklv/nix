{
  pkgs,
  inputs,
  ...
}:
let
  pre-commit-check = import ../../checks/pre-commit-check { inherit inputs pkgs; };
in
pkgs.stdenv.mkDerivation {
  name = "nix";

  nativeBuildInputs = with pkgs; [
    git
    just
    sops

    # Latest statix
    (statix.overrideAttrs (_o: rec {
      src = fetchFromGitHub {
        owner = "oppiliappan";
        repo = "statix";
        rev = "e9df54ce918457f151d2e71993edeca1a7af0132";
        hash = "sha256-duH6Il124g+CdYX+HCqOGnpJxyxOCgWYcrcK0CBnA2M=";
      };

      cargoDeps = pkgs.rustPlatform.importCargoLock {
        lockFile = src + "/Cargo.lock";
        allowBuiltinFetchGit = true;
      };
    }))

    nixd
    deadnix
    nixfmt
  ];

  # Runtime dependencies
  buildInputs = pre-commit-check.enabledPackages;

  # Bootstrapping commands
  shellHook = ''
    # Initiate git hooks
    ${pre-commit-check.shellHook}

    # Fetch latest changes
    git pull
  '';

  # Nix related configurations
  NIX_CONFIG = "extra-experimental-features = nix-command flakes pipe-operators";
}
