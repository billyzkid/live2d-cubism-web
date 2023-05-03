#!/bin/bash
# Resets and cleans the repository and its submodules
# Reference: https://gist.github.com/nicktoumpelis/11214362

# Change the current working directory ($PWD) to the root of the
# repository to ensure this script always behaves consistently
cd $(git rev-parse --show-toplevel)

# Import common variables and functions
source ./scripts/common.sh

# Set step variables
step_cur=0
step_max=4

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
