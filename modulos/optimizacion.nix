{... }:

{
  nix.settings = {
    auto-optimise-store = false;      
    max-jobs = "auto";
    cores = 0;                       
    trusted-users = [ "ivan" ];      

    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise.automatic = true;     
  zramSwap.enable = true;            
  services.fstrim.enable = true;     
  documentation = {
    enable = false;                  
    man.enable = false;              
    nixos.enable = false;            
    doc.enable = false;              
    info.enable = false;             
  };
}
