{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ ];

  xdg.configFile = {
    # astronvim's config
    "nvim".source = inputs.astronvim;

    # my custom astronvim config, astronvim will load it after base config
    # https://github.com/AstroNvim/AstroNvim/blob/v3.32.0/lua/astronvim/bootstrap.lua#L15-L16
    "astronvim/lua/user".source = ./user;
  };

  nixpkgs.config = {
    programs.npm.npmrc = ''
      prefix = ''${HOME}/.npm-global
    '';
  };

  programs = {
    neovim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      # currently we use lazy.nvim as neovim's package manager, so comment this one.
      # plugins = with pkgs.vimPlugins; [
      #   # search all the plugins using https://search.nixos.org/packages
      # ];

      # Extra packages only available to nvim(won't pollute the global home environment)
      extraPackages =
        with pkgs;
        [
          #-- c/c++
          cmake
          cmake-language-server
          gnumake
          checkmake
          gcc # c/c++ compiler, required by nvim-treesitter!
          llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
          lldb

          #-- rust
          rust-analyzer
          cargo # rust package manager
          rustfmt

          #-- zig
          zls

          #-- nix
          # nil
          nixd
          statix # Lints and suggestions for the nix programming language
          deadnix # Find and remove unused code in .nix source files
          nixfmt-rfc-style # Nix Code Formatter

          #-- golang
          go
          gomodifytags
          iferr # generate error handling code for go
          impl # generate function implementation for go
          gotools # contains tools like: godoc, goimports, etc.
          gopls # go language server
          delve # go debugger

          # -- java
          jdk17
          gradle
          maven
          spring-boot-cli

          #-- lua
          stylua
          lua-language-server

          #-- bash
          nodePackages.bash-language-server
          shellcheck
          shfmt

          #-- javascript/typescript --#
          nodePackages.nodejs
          nodePackages.typescript
          nodePackages.typescript-language-server
          # HTML/CSS/JSON/ESLint language servers extracted from vscode
          nodePackages.vscode-langservers-extracted
          nodePackages."@tailwindcss/language-server"

          #-- CloudNative
          nodePackages.dockerfile-language-server-nodejs
          jsonnet
          jsonnet-language-server

          #-- Others
          taplo # TOML language server / formatter / validator
          nodePackages.yaml-language-server
          sqlfluff # SQL linter
          actionlint # GitHub Actions linter
          buf # protoc plugin for linting and formatting
          proselint # English prose linter
          guile # scheme language

          #-- Misc
          tree-sitter # common language parser/highlighter
          nodePackages.prettier # common code formatter
          marksman # language server for markdown
          glow # markdown previewer
          fzf

          #-- Optional Requirements:
          gdu # disk usage analyzer, required by AstroNvim
          ripgrep # fast search tool, required by AstroNvim's '<leader>fw'(<leader> is space key)
        ]
        ++ (
          if pkgs.stdenv.isDarwin then
            [ ]
          else
            [
              #-- verilog / systemverilog
              verible
              gdb
            ]
        );
    };
  };
}
