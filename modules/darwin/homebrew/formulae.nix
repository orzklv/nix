{
  lib,
  config,
  ...
}: let
  apps = lib.mkIf config.homebrew.enable [
    "pkl"
    "mas"
    "mint"
    "sourcery"
    "swiftformat"
    "swiftgen"
    "rustup"
    "swiftlint"
    "xcodegen"
    "localazy/tools/localazy"
    "kiliankoe/formulae/swift-outdated"
    "git-lfs"
    "felixherrmann/tap/swift-package-list"
  ];
in {
  # Homebrew Formulae installations
  homebrew.brews = apps;
}
