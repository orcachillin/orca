{
  inputs,
  pkgs,
  ...
}:
{

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [

    ## gaming

    steam

    ## work, software stuff

    vscode
    opencode
    github-cli
    nixfmt
    # (inputs.kilo.packages.${pkgs.system}.kilo.overrideAttrs (oldAttrs: {
    #   postConfigure = (oldAttrs.postConfigure or "") + ''
    #     sed -i -e 's/if (!semver.satisfies(process.versions.bun, expectedBunVersionRange)) {/if (false) {/' packages/script/src/index.ts
    #   '';
    # }))

    ## messaging

    vesktop
    telegram-desktop
    signal-desktop

    ## music
  ];
}
