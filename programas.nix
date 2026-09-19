{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; 
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  programs.hyprland.enable = true;
  programs.niri.enable = true; 

  programs.kdeconnect.enable = true;
  hardware.graphics.enable32Bit = true;

  fonts.packages = with pkgs; [
    departure-mono
    jetbrains-mono
    nerd-fonts.meslo-lg
  ];

  environment.systemPackages = with pkgs; [
    waybar 
    swaynotificationcenter 
    awww 
    quickshell
    libnotify 
    rofi 
    wl-clipboard 
    cliphist 

    
    grim
    slurp
    satty
    libcanberra-gtk3
    swappy 
    wl-screenrec 

    
    hypridle
    hyprlock
    hyprpicker
    polkit_gnome
    brightnessctl 

    
    ghostty
    zsh
    fastfetch
    btop
    tldr
    neovim

    
    gh
    bun
    python3
    go
    unrar
    sshfs
    sbctl

    brave
    vesktop 
    obsidian
    steam
    qbittorrent-enhanced
    pavucontrol
    networkmanagerapplet
    gparted

    
    catppuccin-grub
    papirus-icon-theme
    volantes-cursors
    bibata-cursors 
    phinger-cursors 
    pywalfox-native
  ];
}
