# Desktop-specific user config for max
{ ... }:

{
  imports = [
    # ./apps/firefox.nix
  ];

  orca.flatpak.apps = [
    "com.moonlight_stream.Moonlight"
    "io.github.lullabyX.sone"
  ];
}
