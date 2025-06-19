set -l seen '__fish_seen_subcommand_from'
set -l has_opt '__fish_contains_opt'

set -l commands shell toggle workspace-action scheme screenshot record clipboard emoji-picker wallpaper pip
set -l not_seen "not $seen $commands"

# Disable file completions
complete -c caelestia -f

# Add help for any command
complete -c caelestia -s 'h' -l 'help' -d 'Show help'

# Subcommands
complete -c caelestia -n $not_seen -a 'shell' -d 'Start the shell or message it'
complete -c caelestia -n $not_seen -a 'toggle' -d 'Toggle a special workspace'
complete -c caelestia -n $not_seen -a 'workspace-action' -d 'Exec a dispatcher in the current group'
complete -c caelestia -n $not_seen -a 'scheme' -d 'Manage the colour scheme'
complete -c caelestia -n $not_seen -a 'screenshot' -d 'Take a screenshot'
complete -c caelestia -n $not_seen -a 'record' -d 'Start a screen recording'
complete -c caelestia -n $not_seen -a 'clipboard' -d 'Open clipboard history'
complete -c caelestia -n $not_seen -a 'emoji-picker' -d 'Toggle the emoji picker'
complete -c caelestia -n $not_seen -a 'wallpaper' -d 'Manage the wallpaper'
complete -c caelestia -n $not_seen -a 'pip' -d 'Picture in picture utilities'

# Shell
set -l commands mpris drawers wallpaper notifs
set -l not_seen "$seen shell && not $seen $commands"
complete -c caelestia -n $not_seen -s 's' -l 'show' -d 'Print all IPC commands'
complete -c caelestia -n $not_seen -s 'l' -l 'log' -d 'Print the shell log'
complete -c caelestia -n $not_seen -a 'mpris' -d 'Mpris control'
complete -c caelestia -n $not_seen -a 'drawers' -d 'Toggle drawers'
complete -c caelestia -n $not_seen -a 'wallpaper' -d 'Wallpaper control (for internal use)'
complete -c caelestia -n $not_seen -a 'notifs' -d 'Notification control'

set -l commands getActive play pause playPause stop next previous list
set -l not_seen "$seen shell && $seen mpris && not $seen $commands"
complete -c caelestia -n $not_seen -a 'play' -d 'Play media'
complete -c caelestia -n $not_seen -a 'pause' -d 'Pause media'
complete -c caelestia -n $not_seen -a 'playPause' -d 'Play/pause media'
complete -c caelestia -n $not_seen -a 'next' -d 'Skip to next song'
complete -c caelestia -n $not_seen -a 'previous' -d 'Go to previous song'
complete -c caelestia -n $not_seen -a 'stop' -d 'Stop media'
complete -c caelestia -n $not_seen -a 'list' -d 'List media players'
complete -c caelestia -n $not_seen -a 'getActive' -d 'Get a property from the active MPRIS player'

set -l commands trackTitle trackArtist trackAlbum position length identity
set -l not_seen "$seen shell && $seen mpris && $seen getActive && not $seen $commands"
complete -c caelestia -n $not_seen -a 'trackTitle' -d 'Track title'
complete -c caelestia -n $not_seen -a 'trackArtist' -d 'Track artist'
complete -c caelestia -n $not_seen -a 'trackAlbum' -d 'Track album'
complete -c caelestia -n $not_seen -a 'position' -d 'Track position'
complete -c caelestia -n $not_seen -a 'length' -d 'Track length'
complete -c caelestia -n $not_seen -a 'identity' -d 'Player identity'

set -l commands list toggle
set -l not_seen "$seen shell && $seen drawers && not $seen $commands"
complete -c caelestia -n $not_seen -a 'list' -d 'List togglable drawers'
complete -c caelestia -n $not_seen -a 'toggle' -d 'Toggle a drawer'

set -l commands (caelestia shell drawers list)
complete -c caelestia -n "$seen shell && $seen drawers && $seen toggle && not $seen $commands" -a "$commands" -d 'drawer'

set -l commands list get set
set -l not_seen "$seen shell && $seen wallpaper && not $seen $commands"
complete -c caelestia -n $not_seen -a 'list' -d 'List wallpapers'
complete -c caelestia -n $not_seen -a 'get' -d 'Get current wallpaper path'
complete -c caelestia -n $not_seen -a 'set' -d 'Change wallpaper'
complete -c caelestia -n "$seen shell && $seen wallpaper && $seen set" -F

complete -c caelestia -n "$seen shell && $seen notifs && not $seen clear" -a 'clear' -d 'Clear popup notifications'

# Toggles
set -l commands communication music specialws sysmon todo
complete -c caelestia -n "$seen toggle && not $seen drawers && not $seen $commands" -a "$commands" -d 'toggle'

# Workspace action
set -l commands workspace workspacegroup movetoworkspace movetoworkspacegroup
complete -c caelestia -n "$seen workspace-action && not $seen $commands" -a "$commands" -d 'action'

# Scheme
complete -c caelestia -n "$seen scheme" -s 'r' -l 'random' -d 'Switch to a random scheme'
complete -c caelestia -n "$seen scheme" -s 'n' -l 'name' -d 'Set scheme name'
complete -c caelestia -n "$seen scheme" -s 'f' -l 'flavour' -d 'Set scheme flavour'
complete -c caelestia -n "$seen scheme" -s 'm' -l 'mode' -d 'Set scheme mode' -a 'light dark'
complete -c caelestia -n "$seen scheme" -s 'v' -l 'variant' -d 'Set scheme variant' -a 'vibrant tonalspot expressive fidelity fruitsalad rainbow neutral content monochrome'

# Record
complete -c caelestia -n "$seen record" -s 'r' -l 'region' -d 'Capture region'
complete -c caelestia -n "$seen record" -s 's' -l 'sound' -d 'Capture sound'

# Clipboard
complete -c caelestia -n "$seen clipboard" -s 'd' -l 'delete' -d 'Delete from cliboard history'

# Wallpaper
complete -c caelestia -n "$seen wallpaper" -s 'p' -l 'print' -d 'Print the scheme for a wallpaper' -rF
complete -c caelestia -n "$seen wallpaper" -s 'r' -l 'random' -d 'Switch to a random wallpaper' -rF
complete -c caelestia -n "$seen wallpaper" -s 'f' -l 'file' -d 'The file to switch to' -rF
complete -c caelestia -n "$seen wallpaper" -s 'n' -l 'no-filter' -d 'Do not filter by size'
complete -c caelestia -n "$seen wallpaper" -s 't' -l 'threshold' -d 'The threshold to filter by' -r
complete -c caelestia -n "$seen wallpaper" -s 'N' -l 'no-smart' -d 'Disable smart mode switching'

# Pip
complete -c caelestia -n "$seen pip" -s 'd' -l 'daemon' -d 'Start in daemon mode'
