
{ self }: {
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.rum.programs.fish;
in {
  options.rum.programs.fish = {
    enable = lib.mkEnableOption "Enable Fish shell and configuration";
    defaultShell = lib.mkEnableOption "Set Fish as default shell";
    wrapperPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra packages wrapped in Fish shell env";
    };
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of fisher plugins to install";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fish
      fzf
      starship
      eza
      bat
      fd
      zoxide
      atuin
      g-ls
    ] ++ cfg.wrapperPackages;

    # Symlink fish config subfiles (without fish_variables)
    hj.files = {
      ".config/fish/config.fish".source = "${self}/fish-config/config.fish";
      ".config/fish/functions".source = "${self}/fish-config/functions";
      ".config/fish/completions".source = "${self}/fish-config/completions";
      ".config/fish/conf.d".source = "${self}/fish-config/conf.d";
      ".config/fish/themes".source = "${self}/fish-config/themes";
      ".config/fish/abbreviations.fish".source = "${self}/fish-config/abbreviations.fish";
      ".config/fish/aliases.fish".source = "${self}/fish-config/aliases.fish";
      ".config/fish/fish_plugins".source = "${self}/fish-config/fish_plugins";
      ".config/fish/user_variables.fish".source = "${self}/fish-config/user_variables.fish";
    };

    # Auto set default shell (system level, persistent)
    system.activationScripts.setFishShell = lib.mkIf cfg.defaultShell ''
      if [ "$(getent passwd ${config.users.users.${config.mainUser}.name} | cut -d: -f7)" != "${pkgs.fish}/bin/fish" ]; then
        echo "Setting fish as default shell for ${config.mainUser}"
        chsh -s ${pkgs.fish}/bin/fish ${config.mainUser}
      fi
    '';

    # Auto-install Fisher plugins (if any)
    system.activationScripts.installFisher = lib.mkIf (cfg.plugins != []) ''
      echo "Installing fisher plugins for fish..."
      export HOME=/home/${config.mainUser}
      sudo -u ${config.mainUser} fish -c 'fisher install ${lib.concatStringsSep " " cfg.plugins}'
    '';
  };
}

