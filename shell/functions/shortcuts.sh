# Shortcuts - Prefix (goto_...)

goto_home() {
  cd "$HOME" || exit
}

goto_downloads() {
  cd "$HOME/Downloads" || exit
}

goto_programming() {
    cd "$HOME/Programming" || exit
}

dots() {
    cd "$HOME/dotfiles" || exit
    code .
}