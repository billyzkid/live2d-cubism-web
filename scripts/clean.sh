#!/bin/bash
# Cleans the packages in the repository

# Change the current working directory ($PWD) to the root of the
# repository to ensure this script always behaves consistently
cd $(git rev-parse --show-toplevel)

# Import common variables and functions
source ./scripts/common.sh

# Set step variables
step_cur=0
step_max=2

step "Cleaning Framework..."
  npm run clean --prefix ./Framework | trim
pets

step "Cleaning Samples..."
  npm run clean --prefix ./Samples/Samples/TypeScript/Demo | trim
pets
