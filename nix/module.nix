
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

   
   # Symlink only individual subfolders, avoiding fish_variables
    hj.files.".config/fish/config.fish".source = "${self}/fish-config/config.fish";
    hj.files.".config/fish/functions".source = "${self}/fish-config/functions";
    hj.files.".config/fish/completions".source = "${self}/fish-config/completions";
    hj.files.".config/fish/conf.d".source = "${self}/fish-config/conf.d";
    hj.files.".config/fish/themes".source = "${self}/fish-config/themes";
    hj.files.".config/fish/abbreviations.fish".source = "${self}/fish-config/abbreviations.fish";
    hj.files.".config/fish/aliases.fish".source = "${self}/fish-config/aliases.fish";
    hj.files.".config/fish/fish_plugins".source = "${self}/fish-config/fish_plugins";
    hj.files.".config/fish/user_variables.fish".source = "${self}/fish-config/user_variables.fish";

  };
}

