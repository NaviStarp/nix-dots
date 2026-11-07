{ pkgs,inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XCURSOR_THEME = "apple_cursor";
    XCURSOR_SIZE = "24";
  };

  programs.hyprland.enable = true;
  programs.niri.enable = true;
  programs.sway = {
    enable = true;
    package = pkgs.swayfx;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-volman
      thunar-archive-plugin
    ];
  };

  programs.xfconf.enable = true;

  services.gvfs.enable = true;
  services.tumbler.enable = true;

  virtualisation.docker.enable = true;
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
  };
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
    gammastep
    tela-icon-theme

    grim
    slurp
    satty
    libcanberra-gtk3
    libnotify
    ffmpeg
    swappy
    wl-screenrec

    hypridle
    hyprlock
    hyprpicker
    polkit_gnome
    brightnessctl

    ghostty
    fastfetch
    btop
    tldr
    inputs.antigravity.packages.${pkgs.system}.default
    inputs.antigravity.packages.${pkgs.system}.google-antigravity-cli 

    gh
    bun
    pnpm
    python3
    go
    go-task
    docker
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

    papirus-icon-theme
    apple-cursor
    volantes-cursors
    bibata-cursors
    phinger-cursors
    pywalfox-native
  ];
}
