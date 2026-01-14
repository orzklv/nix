{
  inputs,
  config,
  ...
}:
let
  key = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    # Path to key file for unlocking secrets
    age.keyFile = key;
    # Default file that contains list of secrets
    defaultSopsFile = ../../../secrets/secrets.yaml;
    # The format of the secret file
    defaultSopsFormat = "yaml";
  };

  # Leave here configs that should be applied only at linux machines
  # sops.secrets = {
  #   "nixpkgs/github" = {};
  #   "nix-serve/public" = {};
  #   "nix-serve/private" = {};
  # };

  # Copy generated copy of fastfetch to here
  # home.file.".config/nix/nix.conf" = {
  #   source = pkgs.writeTextFile {
  #     name = "nix.conf";
  #     text = ''
  #       secret-key-files = ${config.sops.secrets."nix-serve/private".path}
  #       access-tokens = github.com=${config.sops.placeholder."nixpkgs/github"}
  #     '';
  #   };
  # };
}
