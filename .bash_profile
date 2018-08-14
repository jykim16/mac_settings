alias ls='ls -F'
alias vi='vim'
alias mkcd='_(){ mkdir $1; cd $1; }; _'
alias ff='find . -name $1'
alias histgrep='history | grep'

#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /anaconda3/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
export PATH=$PATH:/anaconda3/bin:~/bin:~/bin/flutter/bin
