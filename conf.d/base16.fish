if test -n "$base16_theme" && status --is-interactive && tmux -z "$TMUX"
  base16-$base16_theme
end
