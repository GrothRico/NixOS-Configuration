{ config, pkgs, ... }:

{
  home.username = "rico-groth"; # TODO: variable instead of string
  home.homeDirectory = "/home/rico-groth"; # TODO: inject variable here, too

  # TL;DR read release notes if you really want to update
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "discord"
  ];

  home.packages = with pkgs; [
    neovim
    i3
    firefox
    alacritty

    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; }) TODO:
    # Example for small commands:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # ".test".source = rico-groth/dotfiles/test;
    # ".plain".text = ''
    #  This is a test file with inline text.
    # '';
  };

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Rico Groth";
      userEmail = "groth.rico@protonmail.com";
    };
    fish = {
      enable = true;
      shellAliases = {
        gst = "git status";
        gs = "git stash --include-untracked";
        ga = "git add .";
      };
    };
    alacritty.enable = true;
  };

  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
    };
  };
}
