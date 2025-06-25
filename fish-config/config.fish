source ~/.config/fish/user_variables.fish
source ~/.config/fish/abbreviations.fish
source ~/.config/fish/aliases.fish
atuin init fish --disable-ctrl-r | source
any-nix-shell fish --info-right | source
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
