{ lib }:

{
  # WARNING!
  # Becomes impure when opath provided
  mapSystem =
    { list
    , inputs
    , outputs
    , opath ? ../.
    }:
    let
      # Generate absolute path to the configuration
      path = name: opath + "/nixos/${lib.toLower name}/configuration.nix";

      #   Name  =                Value
      # "Lorem" = self.lib.config.makeSystem "station";
      system = name: {
        name = name;
        value = lib.orzklv.config.makeSystem {
          inherit inputs outputs;
          path = path name;
        };
      };

      # [
      #   { name = "Lorem", value = config }
      #   { name = "Ipsum", value = config }
      # ]
      map = lib.map system list;
    in
    lib.listToAttrs map;

  makeSystem =
    { path
    , inputs
    , outputs
    }:
    lib.nixosSystem {
      specialArgs = {
        inherit inputs outputs;
      };
      modules = [
        # > Our main nixos configuration file <
        path
      ];
    };

  # Generate homeConfigurations from:
  # homeConfigurations = mapHome { inherit inputs, outputs } {
  #   apple = {
  #     inherit inputs outputs;
  #     user = "sakhib";
  #     arch = "aarch64-darwin";
  #     repo = nixpkgs;
  #     aliases = [ "Sokhibjons-iMac.local" "Sokhibjons-MacBook-Pro.local" ];
  #   };
  #   nixos = {
  #     inherit inputs outputs;
  #     user = "sakhib";
  #     arch = "x86_64-linux";
  #     repo = nixpkgs-unstable;
  #     aliases = [ "" ];
  #   };
  # };
  mapHome =
    { inputs
    , outputs
    , opath ? ../home.nix
    }: attr:
    let
      # For each element in the list generate home configuration
      map = lib.mapAttrs
        (name: value:
          lib.orzklv.config.attrHome {
            inherit inputs outputs name;
            path = opath;
            user = value.user;
            arch = value.arch;
            repo = value.repo;
            alias = value.aliases;
          })
        attr;

      # Merge all lists inside list
      flat = lib.flatten (lib.attrValues map);

      # Convert the list of name-value pairs to an attribute set
      cfg = lib.listToAttrs flat;
    in
    cfg;

  attrHome =
    { name
    , user ? " sakhib "
    , arch ? "
        x86_64-linux "
    , repo ? <nixpkgs>
    , alias ? [ ]
    , path
    , inputs
    , outputs
    }:
    let
      main =
        {
          name = "${user}@${name}";
          value = lib.orzklv.config.makeHome {
            inherit inputs outputs;
            path = path;
            arch = arch;
            repo = repo;
          };
        };

      binding = user: name: if name == "" then user else "${user}@${name}";

      aliases = lib.map
        (name:
          {
            name = binding user name;
            value = main.value;
          }
        )
        alias;
    in
    [ main ] ++ aliases;

  makeHome =
    { path
    , arch ? "x86_64-linux"
    , repo ? <nixpkgs>
    , inputs
    , outputs
    }:
    inputs.home-manager.lib.homeManagerConfiguration
      {
        pkgs =
          repo.legacyPackages."${arch}"; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          # > Our main home-manager configuration file <
          path # ./home.nix
        ];
      };
}
