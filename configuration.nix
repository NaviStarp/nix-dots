{ pkgs, lib, ... }:

{
  system.stateVersion = "26.05";

  imports = [
    ./hardware-configuration.nix
    ./programas.nix
    ./modulos/zsh.nix
    ./modulos/nvim.nix
    ./modulos/optimizacion.nix
    ./modulos/navegador.nix
  ];

  # Raton razer
  services.flatpak.enable = true;
  services.udev.extraRules = ''
    ACTION!="remove", SUBSYSTEM=="hid", DRIVERS=="razermouse", RUN+="${pkgs.bash}/bin/bash -c 'echo -ne \\x03\\x00 > /sys/bus/hid/drivers/razermouse/0*/device_mode'"
  '';
  hardware.openrazer.enable = false;

  boot.loader.systemd-boot.enable = lib.mkForce false;
  # boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  # Lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
    configurationLimit = 10;
  };

  # Configuración EFI
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Kernel y gráficos
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];

  # Animación gráfica de arranque con Plymouth
  boot.plymouth = {
    enable = true;
    theme = "breeze"; # Puedes usar "breeze", "spinner", o instalar temas adicionales
  };

  # Silenciar los mensajes de texto del kernel para que la animación sea limpia
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_level=3"
    "video=HDMI-A-1:1920x1080@75e"
    "video=DP-1:1920x1080@75"
    "fbcon=map:0"
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

  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;
  };

  services.xserver.xkb = {
    layout = "es";
    variant = "nodeadkeys";
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
      "wheel"
      "networkmanager"
      "video"
      "render"
      "docker"
    ];
  };
  services.ratbagd.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      sway = {
        default = lib.mkForce [
          "wlr"
          "gtk"
        ];
      };
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
    4321
  ];

}
