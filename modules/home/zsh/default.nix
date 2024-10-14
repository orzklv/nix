{ pkgs, ... }:
let
  is-mac =
    pkgs.stdenv.hostPlatform.system == "aarch64-darwin"
    || pkgs.stdenv.hostPlatform.system == "x86_64-darwin";

  extra = ''
    # Global settings
    setopt AUTO_CD
    setopt BEEP
    setopt HIST_BEEP
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_IGNORE_DUPS
    setopt HIST_REDUCE_BLANKS
    setopt HIST_SAVE_NO_DUPS
    setopt HIST_VERIFY
    setopt INC_APPEND_HISTORY
    setopt INTERACTIVE_COMMENTS
    setopt MAGIC_EQUAL_SUBST
    setopt NO_NO_MATCH
    setopt NOTIFY
    setopt NUMERIC_GLOB_SORT
    setopt PROMPT_SUBST
    setopt SHARE_HISTORY

    # Key bindings
    bindkey -e
    bindkey '^U' backward-kill-line
    bindkey '^[[2~' overwrite-mode
    bindkey '^[[3~' delete-char
    bindkey '^[[H' beginning-of-line
    bindkey '^[[1~' beginning-of-line
    bindkey '^[[F' end-of-line
    bindkey '^[[4~' end-of-line
    bindkey '^[[1;5C' forward-word
    bindkey '^[[1;5D' backward-word
    bindkey '^[[3;5~' kill-word
    bindkey '^[[5~' beginning-of-buffer-or-history
    bindkey '^[[6~' end-of-buffer-or-history
    bindkey '^[[Z' undo
    bindkey ' ' magic-space

    # History files
    HISTFILE=~/.zsh_history
    HIST_STAMPS=mm/dd/yyyy
    HISTSIZE=5000
    SAVEHIST=5000
    ZLE_RPROMPT_INDENT=0
    WORDCHARS=''${WORDCHARS//\/}
    PROMPT_EOL_MARK=
    TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

    # Zsh Autosuggestions Configs
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=gray"

    # Zsh Completions Configs
    zstyle ':completion:*:*:*:*:*' menu select
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
    zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
    zstyle ':completion:*' auto-description 'specify: %d'
    zstyle ':completion:*' completer _expand _complete
    zstyle ':completion:*' format 'Completing %d'
    zstyle ':completion:*' group-name ' '
    zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
    zstyle ':completion:*' rehash true
    zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
    zstyle ':completion:*' use-compctl false
    zstyle ':completion:*' verbose true
    zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_STYLES[default]=none
    ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=gray,underline
    ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
    ZSH_HIGHLIGHT_STYLES[path]=bold
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
    ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[command-substitution]=none
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[process-substitution]=none
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
    ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[assign]=none
    ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
    ZSH_HIGHLIGHT_STYLES[named-fd]=none
    ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
    ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
    ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
    ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout

    ${mac-extra}

    # Extra services
    # here...
  '';

  mac-extra = if is-mac then ''
    # Cargo
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

    # Golang's Trash
    export GOPATH="$HOME/.go"
    export PATH="$PATH:$HOME/.go/bin"
  '' else '''';

in
{
  imports = [
    ./alias.nix
    ./zoxide.nix
    ./starship.nix
  ];

  # I use zsh, but bash and fish work just as well here. This will setup
  # the shell to use home-manager properly on startup, neat!
  programs.zsh = {
    # Install zsh
    enable = true;

    # ZSH Autosuggestions
    # The option `programs.zsh.enableAutosuggestions' defined in config
    # has been renamed to `programs.zsh.autosuggestion.enable'.
    autosuggestion.enable = true;

    # ZSH Completions
    enableCompletion = true;

    # ZSH Syntax Highlighting
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    # Extra manually typed configs
    initExtra = extra;
  };
}
