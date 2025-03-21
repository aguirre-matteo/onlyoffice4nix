# Onlyoffice on Nix

## What is this?

This repository offers a Home-Manager module for configurating
your [Onlyoffice's](https://www.onlyoffice.com/) config declaratively!

> ![NOTE]
> This module has been merged on Home-Manager's unstable branch. This repo will.be available until next stable release (25.5)

# Installation

This guide assumes you have flakes enabled on your NixOS or Nix config.

## First step

Add this flake as an input in your `flake.nix` that contains your NixOS configuration.

```flake.nix 
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ...
    onlyoffice4nix.url = "github:aguirre-matteo/onlyoffice4nix";
  };
}
```
The provided Home-Manager module can be found at `inputs.onlyoffice4nix.homeManagerModule`.

## Second step

Add the module to Home-Manager's `sharedModules` list.

```flake.nix
outputs = { self, nixpkgs, home-manager, ... }@inputs: {
  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix 
      
      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExntesion = "bkp";

          sharedModules = [
            inputs.onlyoffice4nix.homeManagerModule       # <--- this will enable the module
          ];

          user.yourUserName = import ./path/to/home.nix
        };
      }
    ]; 
  };
};
```

# Configuration

The following options are available at `programs.onlyoffice`:

`enable`

Whatever to enable or not Onlyoffice. Default: false

`package`

The Onlyoffice package will be used. This option is usefull when
overriding the original package. Default: `pkgs.onlyoffice-desktopeditors`

`settings`

All the configurations for Onlyoffice. All configurable options can be deduced 
by enabling them through the GUI and observing the changes in 
~/.config/onlyoffice/DesktopEditors.conf.

## Example config 

```home.nix
{
  programs.onlyoffice = {
    enable = true;
    settings = {
      UITheme = "theme-contrast-dark";
      editorWindowMode = false;
      forcedRtl = false;
      maximized = true;
      titlebar = "custom";
    };
  };
}
```
