# Server-specific user config for max
{ ... }:

{
  users.users.max.extraGroups = [ "wheel" "docker" ];
}
