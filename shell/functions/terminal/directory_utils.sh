# Directory utils - Prefix (dir_...)

dir_count_files() {
  ls -l $1 | wc -l
}

dir_count_directories() {
  ls -l $1 | grep "^d" | wc -l
}