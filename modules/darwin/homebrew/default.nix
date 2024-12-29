{
  ...
}: {
  imports = [
    ./mas.nix
    ./taps.nix
    ./casks.nix
    ./formulae.nix
  ];

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };
}
