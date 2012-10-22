# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# load google app engine binaries into path
export PATH=/home/fabian/gae:$PATH

#WINEPREFIX=.wine


PS1='\u \W\$ '
#PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# This should be the default in all distributions
fortune

