{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    historyLimit = 100000;

    plugins = with pkgs.tmuxPlugins; [
      cpu
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-plugins "cpu-usage git ssh-session"
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10

          set -g @dracula-network-bandwidth enp9s0
          set -g @dracula-network-bandwidth-interval 1
          set -g @dracula-network-bandwidth-show-interface true

        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];

    extraConfig = ''
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };
}
