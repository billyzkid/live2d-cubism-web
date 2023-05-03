#!/bin/bash
# Exports common variables and functions

# Set color variables
color_off="\033[0m"
color_red="\033[0;31m"
color_green="\033[0;32m"
color_yellow="\033[0;33m"
color_magenta="\033[0;35m"
color_cyan="\033[0;36m"

# Trims the piped input
trim() {
  grep -o -E "\S.*\S|\S"
}

# Reads a single key
read_key() {
  echo -n -e "$1 "
  read -n 1 key
  echo
}

# Reads a single key that answers a yes or no question
read_yes_no_key() {
  # Ask the question
  read_key "${color_yellow}$1${color_off}"
  # Loop until we get a valid answer
  while true; do
    case $key in
      [yY]) return 0 ;; # Yes
      [nN]) return 1 ;; # No
      *) read_key "${color_red}${2:-$1}${color_off}" # Ask again, complain, etc.
    esac
  done
}

# Prompts the user to answer a yes or no question
# and exits the script if the answer is no
confirm() {
  echo
  if ! read_yes_no_key "$1" "${2:-$1}"; then exit 1; fi
  echo
}

# Displays a message when a new step begins
step () {
  ((step_cur++))
  if (($step_cur > 1)); then echo; fi
  echo -e "${color_green}Step $step_cur of $step_max: ${color_magenta}$1${color_off}"
}

# Displays a message when the current step ends
pets () {
  echo -e "${color_cyan}Done.${color_off}"
}
