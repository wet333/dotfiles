# File utils - Prefix (file_...)

file_count_lines() {
  cat $1 | wc -l
}

file_count_words() {
  cat $1 | wc -w
}

file_count_characters() {
  cat $1 | wc -c
}