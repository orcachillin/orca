{ inputs, ... }:
let
  profile = "default";
in
{
  programs.firefox = {
    enable = true;
    profiles.${profile} = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        # "browser.urlbar.trimHttps" = true;
        # "browser.urlbar.trimURLs" = true;
        "browser.profiles.enabled" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "browser.compactmode.show" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        "browser.tabs.allow_transparent_browser" = true;
        "browser.uidensity" = 1;
        "browser.aboutConfig.showWarning" = false;
        "uc.tweak.urlbar.not-floating" = true;
        "uc.tweak.sidebar.wide" = true;
      };
    };
  };

  home.file.".mozilla/firefox/${profile}/chrome" = {
    source = "${inputs.potatofox}/chrome";
    recursive = true;
  };

  home.file.".mozilla/firefox/${profile}/chrome/overrides.css".text = ''
    :root {
      --uc-transition: 50ms ease-in-out;
      --uc-mouseout-delay: 50ms !important;
    }
  '';
}
