# Auto-imports all subdirectories of users/ as nixos modules
{
imports = builtins.attrValues (
  builtins.mapAttrs (name: type: import ./${name})
    (removeAttrs (builtins.readDir ./.) [ "default.nix" ])
);
}
