{
  # List your web servers here
  home = import ./home.nix;
  work = import ./work.nix;
  kolyma-1 = import ./kolyma-1.nix;
  kolyma-2 = import ./kolyma-2.nix;
}
