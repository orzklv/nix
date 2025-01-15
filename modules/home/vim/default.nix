{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

        lsp = {
          enable = true;
          formatOnSave = true;
        };

        theme = {
          enable = true;
          name = "onedark";
          style = "darker";
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        filetree.nvimTree.enable = true;

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          assembly.enable = true;
          clang.enable = true;
          markdown.enable = true;
          nu.enable = true;
          bash.enable = true;
          nix.enable = true;
          rust.enable = true;

          # Tailored deno experience
          ts = {
            enable = true;
            lsp.server = "denols";
          };
        };
      };
    };
  };
}
