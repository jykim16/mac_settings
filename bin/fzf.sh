#!/bin/bash
# vf [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
# vf - fuzzy open with vim from anywhere
# ex: vf word1 word2 ... (even part of a file name)
fe() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

fnotes() {
  main() {
    previous_file="$1"
    file_to_edit=`select_file $previous_file`
  
    if [ -n "$file_to_edit" ] ; then
      vim "$file_to_edit"
      main "$file_to_edit"
    fi
  }
  
  select_file() {
    given_file="$1"
    fzf --preview="cat {}" --preview-window=right:70%:wrap --query="$given_file"
  }
  
  main ""
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fhist - repeat history
fhist() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fmux - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `fmux` will allow you to select your tmux session via fzf.
# `fmux irc` will attach to the irc session (if it exists), else it will create it.

fmux() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
