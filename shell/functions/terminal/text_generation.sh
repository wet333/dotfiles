# Text-generation utility functions - Prefix (textg_...)

# Dates and times
textg_date_dmy() {
  date '+%d-%m-%Y'
}

textg_date_ymd() {
  date '+%Y-%m-%d'
}

textg_time_hms() {
  date '+%H:%M:%S'
}

textg_time_hm() {
  date '+%H:%M'
}

# Random text
textg_random_text() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}