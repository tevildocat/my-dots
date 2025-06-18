source /usr/share/cachyos-fish-config/cachyos-config.fish
set -Ux TERM xterm-256color
# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    fastfetch #--config examples/13
end

#alias ls='eza -a --color=always --group-directories-first --icons' # preferred listing
#alias la='eza -al --color=always --group-directories-first --icons'  # all files and dirs
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias drd='dragon-drop -x -i -T $1'
alias start_vpn='adguardvpn-cli connect'
alias stop_vpn='adguardvpn-cli disconnect'

alias gG='cd ~/Games'

cat ~/.cache/wal/sequences

