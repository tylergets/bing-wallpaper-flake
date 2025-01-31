# Bing Wallpaper Flake

A nightly updating flake that gets the URL and hash of the latest Microsoft Bing wallpaper.

## Usage

Add to your flake.nix
```nix
bing-wallpaper-flake = {
    url = "github://tylergets/bing-wallpaper-flake";
    inputs.nixpkgs.follows = "nixpkgs";
};
```

Use in stylix or however else you manage wallpapers. An example below

```nix
{
  pkgs,
  inputs,
  lib,
  specialArgs,
  config,
  ...
}: let
  wallpaper = builtins.toString inputs.bing-wallpaper-flake.packages.x86_64-linux.image.out;
in {
  home-manager.sharedModules = [
    ({config, ...}: {
      home.file = {
        background-image = {
          target = ".background-image";
          source = wallpaper;
          recursive = true;
          onChange = "${pkgs.feh}/bin/feh --bg-scale ${wallpaper}";
        };
      };
    })
  ];
}
```

This will give you a new daily wallpaper each time you run `nix flake update`