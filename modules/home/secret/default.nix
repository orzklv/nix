{
  outputs,
  inputs,
  config,
  ...
}: let
  key = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
in {
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
}
