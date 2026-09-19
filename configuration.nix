{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./programas.nix
    ./modulos/zsh.nix
    ./modulos/nvim.nix
    ./modulos/optimizacion.nix
  ];

  # Raton razer
  services.flatpak.enable = true;
  services.udev.extraRules = ''
    ACTION!="remove", SUBSYSTEM=="hid", DRIVERS=="razermouse", RUN+="${pkgs.bash}/bin/bash -c 'echo -ne \\x03\\x00 > /sys/bus/hid/drivers/razermouse/0*/device_mode'"
  '';
  hardware.openrazer.enable = false;

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.kernelParams = [
    "video=HDMI-A-1:1920x1080@75e" # La 'e' al final fuerza el "Enable" (activado)
    "video=DP-1:1920x1080@75"
    "fbcon=map:0" # Mapea la consola al primer dispositivo detectado
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  console.keyMap = "es";

  services.printing.enable = true;

  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.ivan = {
    isNormalUser = true;
    description = "Ivan";
    extraGroups = [
      "openrazer"
      "networkmanager"
      "wheel"
    ];
  };
  services.ratbagd.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
      };
    };
  };


  programs.hyprland.enable = true;

  networking.firewall.allowedTCPPorts = [
    80
    443
    4321
  ];

}
