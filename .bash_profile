# Aliases
alias ls='ls -F'
alias vi='vim'
alias mkcd='_(){ mkdir $1; cd $1; }; _'
alias ff='find . -name $1'
alias histgrep='history | grep'

#virtuenvwrapper
source /usr/local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/.virtualenvs

#bin folder sourcing
export FZF_DEFAULT_OPTS="--reverse --inline-info --height 50%"
source ~/bin/fzf.sh

export PATH=$PATH:/anaconda3/bin:~/bin:~/bin/flutter/bin
