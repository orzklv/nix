{ pkgs, ... }: {
  config = {
    programs.helix = {
      enable = true;

      settings = {
        theme = "autumn_night";

        editor = {
          line-number = "relative";

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          file-picker = {
            hidden = false;
            git-ignore = true;
            git-global = true;
          };

          lsp = {
            enable = true;
            display-messages = true;
            display-inlay-hints = true;
          };

          statusline = {
            left = [ "mode" "spinner" "read-only-indicator" "file-modification-indicator" ];

            center = [ "file-name" ];

            right = [
              "diagnostics"
              "selections"
              "position"
              "file-encoding"
              "file-line-ending"
              "file-type"
            ];

            separator = "│";

            mode = {
              normal = "SLAVE";
              insert = "MASTER";
              select = "DUNGEON";
            };
          };
        };

        keys.normal = {
          # Easy window movement
          "C-left" = "jump_view_left";
          "C-right" = "jump_view_right";
          "C-up" = "jump_view_up";
          "C-down" = "jump_view_down";

          "C-r" = ":reload";
        };
      };

      extraPackages = with pkgs;
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
          nil
          nixd
          nixpkgs-fmt
          nixpkgs-lint

          # nixd
          statix # Lints and suggestions for the nix programming language
          deadnix # Find and remove unused code in .nix source files
          alejandra # Nix Code Formatter

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
          emmet-ls
          jsonnet
          jsonnet-language-server
          hadolint # Dockerfile linter

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
          gdu # disk usage analyzer
          ripgrep # fast search tool
        ]
        ++ (
          if pkgs.stdenv.isDarwin
          then [ ]
          else [
            #-- verilog / systemverilog
            verible
            gdb
          ]
        );
    };
  };
}
