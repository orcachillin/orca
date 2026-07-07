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
    bun
    inputs.kilo.packages.${pkgs.system}.kilo

    ## messaging

    vesktop
    telegram-desktop
    signal-desktop

    ## music
  ];
}
