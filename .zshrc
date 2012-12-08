# The following lines were added by compinstall

#zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completer _expand _complete 
zstyle :compinstall filename '/home/fabian/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
# bindkey -v
# End of lines configured by zsh-newuser-install

bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word


export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.9/

PS1='%n %~%% '

# load google app engine binaries into path
export PATH=/home/fabian/gae:$PATH
export PATH=/home/fabian/.local/bin:$PATH

# wine is on another drive
export WINEPREFIX=/media/wdc/home/fabian/.wine

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


fortune
