alias ls='ls -F'
alias vi='vim'

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /anaconda3/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
export PATH=$PATH:/anaconda3/bin:~/bin:~/bin/flutter/bin
