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
          # python dns having hard times to build
          # cmake-language-server
          gnumake
          checkmake
          gcc # c/c++ compiler, required by nvim-treesitter!
          llvmPackages.clang-unwrapped # c/c++ tools with clang-tools such as clangd
          lldb

          #-- rust
          rust-analyzer
          cargo # rust package manager
          rustfmt

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

          #-- bash
          nodePackages.bash-language-server
          shellcheck
          shfmt

          #-- CloudNative
          jsonnet
          jsonnet-language-server

          #-- Others
          taplo # TOML language server / formatter / validator
          sqlfluff # SQL linter
          actionlint # GitHub Actions linter
          proselint # English prose linter

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
          if stdenv.isDarwin
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
