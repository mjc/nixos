{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    autocd = true; # typing /foo will do cd /foo if /foo is a directory.

    enableVteIntegration = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = ["git" "thefuck" "history" "rust" "fd" "gh" "mosh" "ssh-agent" "sudo" "tmux"];
      theme = "robbyrussell";
      extraConfig = ''
        PATH=$HOME/.cargo/bin:$HOME/.npm-packages/bin:$PATH
      '';
    };
  };
}
