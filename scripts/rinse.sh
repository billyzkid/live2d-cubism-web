#!/bin/bash
# Resets and cleans the repository and its submodules
# Reference: https://gist.github.com/nicktoumpelis/11214362

# Change the current working directory ($PWD) to the root of the
# repository to ensure this script always behaves consistently
cd $(git rev-parse --show-toplevel)

# Set color variables
color_off="\033[0m"
color_red="\033[0;31m"
color_green="\033[0;32m"
color_yellow="\033[0;33m"
color_magenta="\033[0;35m"
color_cyan="\033[0;36m"

# Set step variables
step_cur=0
step_max=4

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

# Check if there are any changes in the repository
# and confirm whether or not to proceed
# Reference: https://git-scm.com/docs/git-status
if [ -n "$(git status --porcelain)" ]; then
  git status
  confirm "Warning! This will obliterate the changes shown above. Should I proceed? (y/n)" \
          "Sorry, I didn't understand your answer. Please type 'y' to proceed or 'n' to exit. (y/n)"
fi

# Reset the repository
# Reference: https://git-scm.com/docs/git-reset
step "Resetting working tree and submodules..."
  git reset --hard --recurse-submodules
pets

# Synchronize the submodules
# Reference: https://git-scm.com/docs/git-submodule
step "Synchronizing submodules..."
  git submodule sync --recursive
pets

# Update the submodules
# Reference: https://git-scm.com/docs/git-submodule
step "Updating submodules..."
  git submodule update --init --force --recursive
pets

# Clean the repository
# Reference: https://git-scm.com/docs/git-clean
step "Cleaning working tree and submodules..."
  git clean -d -x --force --force
  git submodule foreach --recursive git clean -d -x --force --force
pets
