
{ self }: {
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    # Install only Fish + related CLI tools
    environment.systemPackages = with pkgs; [
      fish
      fzf
      starship
      eza
      bat
      fd
      zoxide
      atuin
    ];

    # Symlink entire fish-config/ folder to ~/.config/fish
    hj.files.".config/fish".source = "${self}/fish-config";
  };
}

