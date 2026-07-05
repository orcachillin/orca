{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.orca.flatpak;
  grep = pkgs.gnugrep;
in
{
  options.orca.flatpak.apps = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "List of Flatpak application IDs to install declaratively.";
  };

  config = {
    system.activationScripts.flatpakManagement = {
      text = ''
        echo "orca flatpak management: ensuring ${toString cfg.apps}"

        ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
          https://flathub.org/repo/flathub.flatpakrepo

        installedFlatpaks=$(${pkgs.flatpak}/bin/flatpak list --app --columns=application)

        for installed in $installedFlatpaks; do
          if ! echo ${toString cfg.apps} | ${grep}/bin/grep -q $installed; then
            echo "Removing $installed because it's not in the desired flatpaks list."
            ${pkgs.flatpak}/bin/flatpak uninstall -y --noninteractive $installed
          fi
        done

        for app in ${toString cfg.apps}; do
          echo "Ensuring $app is installed."
          ${pkgs.flatpak}/bin/flatpak install -y flathub $app
        done

        ${pkgs.flatpak}/bin/flatpak uninstall --unused -y
        ${pkgs.flatpak}/bin/flatpak update -y
      '';
    };
  };
}
