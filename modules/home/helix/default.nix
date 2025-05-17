{pkgs, ...}: {
  config = {
    programs.helix = {
      enable = true;
      defaultEditor = true;

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
            left = ["mode" "spinner" "read-only-indicator" "file-modification-indicator"];

            center = ["file-name"];

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
          nixd
          statix # Lints and suggestions for the nix programming language
          deadnix # Find and remove unused code in .nix source files
          alejandra # Nix Code Formatter

          #-- bash
          bash-language-server
          shellcheck
          shfmt

          #-- CloudNative
          emmet-ls
          jsonnet
          jsonnet-language-server

          #-- Others
          taplo # TOML language server / formatter / validator
          yaml-language-server
          sqlfluff # SQL linter
          actionlint # GitHub Actions linter

          #-- Misc
          tree-sitter # common language parser/highlighter
          marksman # language server for markdown
          glow # markdown previewer
          fzf
        ]
        ++ (
          if pkgs.stdenv.hostPlatform.isDarwin
          then []
          else [
            #-- verilog / systemverilog
            verible
            gdb
          ]
        );
    };
  };
}
