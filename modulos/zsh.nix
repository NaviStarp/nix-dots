{ pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    
    zsh-powerlevel10k
    eza
    bat
    fzf
    ripgrep
    zoxide
    wl-clipboard

    
    yazi
    ffmpegthumbnailer 
    poppler-utils 
    imagemagick 
    unar 
    jq 
  ];

  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      theme = "";
      plugins = [
        "git"
        "sudo"
        "fzf"
        "history"
        "zoxide"
      ];
    };

    
    shellAliases = {
      ls = "eza --icons auto";
      ll = "eza -l -g --icons";
      la = "eza -la -g --icons";
      tree = "eza --tree --icons";
      cd = "z";
      cat = "bat --paging=never"; 
      update = "sudo nixos-rebuild switch";
      clean = "sudo nix-collect-garbage -d";
    };


    
    promptInit = ''
      
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      
      eval "$(${pkgs.zoxide}/bin/zoxide init zsh)"

      
      function yy() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }
    '';
  };

  
  users.users."ivan" = {
    shell = pkgs.zsh;
  };
}
