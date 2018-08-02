export PATH=$HOME/local/bin:$PATH
set -o vi
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /anaconda3/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh
export PYTHONPATH=$PYTHONPATH:/anaconda3/lib/python3.6/site-packages
