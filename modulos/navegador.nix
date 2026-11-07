{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  system = pkgs.stdenv.hostPlatform.system;
  zenPkg = inputs.zen-browser.packages.${system}.default;

  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  extensions = [
    (extension "ublock-origin" "uBlock0@raymondhill.net")
  ];

  policiesJson = pkgs.writeText "policies.json" (
    builtins.toJSON {
      policies = {
        DisableTelemetry = true;
        ExtensionSettings = builtins.listToAttrs extensions;
        Preferences = {
          "extensions.autoDisableScopes" = 0;
          "extensions.pocket.enabled" = false;
        };
        SearchEngines = {
          Default = "ddg";
          Add = [
            {
              Name = "nixpkgs packages";
              URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
              IconURL = "https://wiki.nixos.org/favicon.ico";
              Alias = "@np";
            }
            {
              Name = "NixOS options";
              URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
              IconURL = "https://wiki.nixos.org/favicon.ico";
              Alias = "@no";
            }
          ];
        };
      };
    }
  );

  zenConfigured = pkgs.symlinkJoin {
    name = "zen-browser-configured";
    paths = [ zenPkg ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # Enlaza las políticas empresariales de Firefox/Zen
      mkdir -p $out/lib/zen/distribution
      ln -s ${policiesJson} $out/lib/zen/distribution/policies.json

      # Si la ruta es bin/zen, asegurar que lea las políticas
      if [ -d $out/bin ]; then
        for bin in $out/bin/*; do
          wrapProgram "$bin" \
            --set-default MOZ_APP_LAUNCHER "$bin"
        done
      fi
    '';
  };
in
{
  environment.systemPackages = [
    zenConfigured
  ];
}
