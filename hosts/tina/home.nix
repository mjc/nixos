{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/cli-internet.nix
    ../../modules/home-manager/cli-media.nix
    ../../modules/home-manager/cli-quality-of-life.nix
    ../../modules/home-manager/dev-tools.nix
    ../../modules/home-manager/dev-tools.nix
    ../../modules/home-manager/file-management.nix
    ../../modules/home-manager/tmux.nix
    ../../modules/home-manager/zsh.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mjc";
  home.homeDirectory = "/home/mjc";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    (writeShellScriptBin "recompress-nzbs" ''
      zfs list -o name,space,compress,compressratio wonderland/downloads/nzbs
      fd 'gz$' /mnt/downloads/nzbs -x gzip -fd
      sleep 5
      zfs list -o name,space,compress,compressratio wonderland/downloads/nzbs
    '')

    # TODO: consolidate these.
    (writeShellScriptBin "av1-6ch" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=128k --enc ac=6"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode ''${video} ''${filter}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd '5\.1' -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-8ch" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=256k --enc ac=8"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode ''${video}  ''${filter}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd '7\.1' -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-stereo" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=48k --enc ac=2"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode ''${video} ''${filter}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd '2\.0' -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "x265-6ch" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=128k --enc ac=6"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode ''${video} ''${scale}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd . -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "x265-8ch" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=256k --enc ac=8"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode $\{video} $\{scale} ''${audio} --scd true --cache true --keyint 30s -i"
      fd . -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "x265-stereo" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=48k --enc ac=2"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode ''${video} ''${scale}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd . -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/mjc/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Mika Cohen";
    userEmail = "mjc@kernel.org";
  };

  home.file = {
    ".cargo/config.toml" = {
      text = ''
        [target.x86_64-unknown-linux-gnu]
        linker = "${pkgs.clang}/bin/clang"
        rustflags = ["-C", "link-arg=--ld-path=${pkgs.mold}/bin/mold", "-C", "target-cpu=native", "-Z", "threads=8"]
      '';
      executable = false;
    };
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
}
