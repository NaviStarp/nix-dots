{ pkgs, ... }:
{

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    git
    gcc 
    unzip 
    curl
    xclip  
    wl-clipboard  
    fd  
    ripgrep  
    fzf  
    nodejs
    (vimPlugins.nvim-treesitter.withPlugins (p: [
      p.lua
      p.nix
      p.astro
      p.javascript
      p.typescript
      p.tsx
      p.html
      p.css
      p.json
      p.jsonc
      p.python
      p.vim
      p.vimdoc
      p.bash
      p.regex
      p.markdown
      p.markdown_inline
    ]))
    nil  
    nixpkgs-fmt  
    gopls  
    jdt-language-server
    lua-language-server  
    astro-language-server  
    typescript-language-server  
    vscode-langservers-extracted  
    tailwindcss-language-server  
    pyright  

  ];
}
