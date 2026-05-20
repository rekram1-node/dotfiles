rvf() {
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  # Adjust NO_OP to echo the filename
  NO_OP='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            echo {1}      # No selection. Echo the current line's filename.
          else
            echo {+f}     # Echo the selected filenames.
          fi'

  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$NO_OP" \
      --bind "ctrl-o:execute:$NO_OP" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
}