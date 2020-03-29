# Luke's config for the Zoomer Shell

export ZPLUG_HOME=~/.config/zsh/.zplug
source ~/.config/zsh/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zstyle ":omz:plugins:ssh-agent" identities github

# enable
SAVEHIST=10000
HISTFILE=~/.zsh_history

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Then, source plugins and add commands to $PATH
zplug load

# Add pyenv to PATH
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# CUDA
export CUDA_VISIBLE_DEVICES=0
export LD_LIBRARY_PATH="/opt/cuda/lib64"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


